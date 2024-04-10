from flask import Flask, session,render_template, request, redirect, url_for, flash, get_flashed_messages
from flask_sqlalchemy import SQLAlchemy
from markdown import markdown
import pymysql
pymysql.install_as_MySQLdb()
from datetime import datetime
import re
from jinja2 import Environment
from mdx_math import MathExtension
from sqlalchemy import text
from sqlalchemy.orm import joinedload
from itertools import groupby

app = Flask(__name__, template_folder='templates', static_folder='/', static_url_path='/')
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:root123@localhost/blog_management'
app.config['SECRET_KEY'] = '123'  # 设置 secret_key
db = SQLAlchemy(app)
# 添加 markdown 过滤器
app.jinja_env.filters['markdown'] = markdown

class Users(db.Model):
    user_id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    password = db.Column(db.String(120), nullable=False)  # 添加密码字段
    email = db.Column(db.String(120), unique=True, nullable=False)
    is_disabled = db.Column(db.Boolean, default=False)

    blogs = db.relationship('Blogs', backref='author')

class Blogs(db.Model):
    blog_id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    content = db.Column(db.Text, nullable=False)
    author_id = db.Column(db.Integer, db.ForeignKey('users.user_id'))
    publish_date = db.Column(db.Date)
    upvotes = db.Column(db.Integer, default=0)  # 添加点赞数字段
    downvotes = db.Column(db.Integer, default=0)  # 添加反赞数字段
    categories = db.relationship('Categories', secondary='blog_categories', backref=db.backref('blogs', lazy=True))
    tags = db.relationship('Tags', secondary='blog_tags', backref=db.backref('blogs', lazy=True))

class UserVotes(db.Model):
    vote_id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'))
    blog_id = db.Column(db.Integer, db.ForeignKey('blogs.blog_id'))
    vote = db.Column(db.SmallInteger)  # 1 表示点赞，-1 表示反赞

    __table_args__ = (
        db.UniqueConstraint('user_id', 'blog_id', name='uix_user_votes'),  # 一个用户只能对每一个博客点一次赞或者反赞
    )

class Comments(db.Model):
    comment_id = db.Column(db.Integer, primary_key=True)
    content = db.Column(db.Text, nullable=False)
    commenter_id = db.Column(db.Integer, db.ForeignKey('users.user_id'))
    blog_id = db.Column(db.Integer, db.ForeignKey('blogs.blog_id'))
    parent_id = db.Column(db.Integer, db.ForeignKey('comments.comment_id'))  # 添加 parent_id 字段

    # 添加一个 relationship
    commenter = db.relationship('Users', backref='comments')
    parent = db.relationship('Comments', remote_side=[comment_id], backref='replies')

class Categories(db.Model):
    category_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)

class BlogCategories(db.Model):
    relation_id = db.Column(db.Integer, primary_key=True)
    blog_id = db.Column(db.Integer, db.ForeignKey('blogs.blog_id'))
    category_id = db.Column(db.Integer, db.ForeignKey('categories.category_id'))

class Tags(db.Model):
    tag_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)

class BlogTags(db.Model):
    relation_id = db.Column(db.Integer, primary_key=True)
    blog_id = db.Column(db.Integer, db.ForeignKey('blogs.blog_id'))
    tag_id = db.Column(db.Integer, db.ForeignKey('tags.tag_id'))

class Admins(db.Model):
    admin_id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50), unique=True, nullable=False)
    password = db.Column(db.String(50), nullable=False)
    email = db.Column(db.String(50))

class Announcements(db.Model):
    announcement_id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    content = db.Column(db.Text, nullable=False)
    admin_id = db.Column(db.Integer, db.ForeignKey('admins.admin_id'))
    publish_date = db.Column(db.Date)

@app.route('/')
def home():
    # 查询所有的博客
    blogs = Blogs.query.all()

    categories = Categories.query.all()  # 查询所有的类别
    for category in categories:
        category.blogs = Blogs.query.join(BlogCategories).filter(BlogCategories.category_id == category.category_id).all()
    
    tags = Tags.query.all()  # 查询所有的标签
    for tag in tags:
        tag.blogs = Blogs.query.join(BlogTags).filter(BlogTags.tag_id == tag.tag_id).all()

    # 查询所有的公告
    announcements = db.session.query(Announcements, Admins.username).join(Admins, Announcements.admin_id == Admins.admin_id).all()

    return render_template('./home/home.html', blogs=blogs, categories=categories, tags=tags, announcements=announcements)  # 将博客、类别、标签和公告传递给模板

@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']  # 获取密码
        # 还需要验证输入

        user = Users.query.filter_by(username=username).first()
        if user is None:
            error = '用户不存在。请先注册。'
        elif user.password != password:  # 假设密码是明文存储的
            error = '密码错误。请重新输入。'
        elif user.is_disabled:  # 检查用户是否被封禁
            error = '此用户已被封禁。'
        else:
            session['user_id'] = user.user_id  # 将用户 ID 存储在会话中，表示用户已登录
            session['username'] = user.username
            return redirect(url_for('home'))

    return render_template('login.html', error=error)

@app.route('/logout')
def logout():
    # 清除会话中的用户 ID
    session.pop('user_id', None)
    # 重定向到首页
    return redirect(url_for('home'))  # 假设你有一个名为 'index' 的路由处理首页


@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']  # 获取密码
        email = request.form['email']
        # Remember to validate the inputs

        existing_user = Users.query.filter_by(username=username).first()
        if existing_user is not None:
            error = '用户名已存在，请选择其他用户名。'
            return render_template('register.html', error=error)

        user = Users(username=username, password=password, email=email) 
        db.session.add(user)
        db.session.commit()

        return redirect(url_for('home'))

    return render_template('register.html')

@app.route('/user_show_announcements')
def user_show_announcements():
    # 获取所有公告的信息
    announcements = db.session.execute(text("SELECT * FROM AnnouncementAdminView"))
    announcements = [dict(row._mapping) for row in announcements]
    return render_template('./home/user_show_announcements.html', announcements=announcements)

@app.route('/user_show_announcement/<int:announcement_id>')
def user_show_announcement(announcement_id):
    # 显示一个公告
    announcement = db.session.execute(text(f"SELECT * FROM AnnouncementAdminView WHERE announcement_id = {announcement_id}"))
    announcement = [dict(row._mapping) for row in announcement][0]
    return render_template('./home/user_show_announcement.html', announcement=announcement)

@app.route('/blog/<int:blog_id>')
def blog(blog_id):
    # 获取指定 ID 的博客以及其作者
    blog = db.session.query(Blogs, Users).join(Users, Blogs.author_id == Users.user_id).filter(Blogs.blog_id == blog_id).first()
    comments = Comments.query.filter_by(blog_id=blog_id).all()  # 获取该博客的所有评论

    # 获取该博客的所有类别和标签
    categories = Categories.query.join(BlogCategories).filter(BlogCategories.blog_id == blog_id).all()
    tags = Tags.query.join(BlogTags).filter(BlogTags.blog_id == blog_id).all()

    # 获取该博客的点赞数和反赞数
    upvotes = UserVotes.query.filter_by(blog_id=blog_id, vote=1).count()
    downvotes = UserVotes.query.filter_by(blog_id=blog_id, vote=-1).count()

    error_messages = get_flashed_messages()  # 获取可能存在的错误信息
    error = error_messages[0] if error_messages else None  # 从列表中取出错误信息
    error = error.replace('"', '') if error else None  # 去掉引号

    if error:  # 如果有错误信息
        return render_template('./blog/blog.html', blog=blog.Blogs, author=blog.Users, comments=comments, categories=categories, tags=tags, upvotes=upvotes, downvotes=downvotes, error=error)
    else:  # 如果没有错误信息
        return render_template('./blog/blog.html', blog=blog.Blogs, author=blog.Users, comments=comments, categories=categories, tags=tags, upvotes=upvotes, downvotes=downvotes)


@app.route('/blog/<int:blog_id>/upvote', methods=['POST'])
def blog_upvote(blog_id):
    # 检查用户是否已登录
    user_id = session.get('user_id')  # 假设你已经在 session 中保存了用户的 ID
    if not user_id:
        flash('请先登录')
        return redirect(url_for('login'))  # 假设你有一个名为 'login' 的路由处理登录

    # 处理点赞请求
    vote = UserVotes.query.filter_by(user_id=user_id, blog_id=blog_id).first()
    if vote:
        vote.vote = 1
    else:
        vote = UserVotes(user_id=user_id, blog_id=blog_id, vote=1)
        db.session.add(vote)
    db.session.commit()
    return redirect(url_for('blog', blog_id=blog_id))

@app.route('/blog/<int:blog_id>/downvote', methods=['POST'])
def blog_downvote(blog_id):
    # 检查用户是否已登录
    user_id = session.get('user_id')  # 假设你已经在 session 中保存了用户的 ID
    if not user_id:
        flash('请先登录')
        return redirect(url_for('login'))  # 假设你有一个名为 'login' 的路由处理登录

    # 处理反赞请求
    vote = UserVotes.query.filter_by(user_id=user_id, blog_id=blog_id).first()
    if vote:
        vote.vote = -1
    else:
        vote = UserVotes(user_id=user_id, blog_id=blog_id, vote=-1)
        db.session.add(vote)
    db.session.commit()
    return redirect(url_for('blog', blog_id=blog_id))


@app.route('/new-blog', methods=['GET', 'POST'])
def new_blog():
    if request.method == 'POST':
        title = request.form['title']
        content = request.form['content']
        author_id = session['user_id']  
        publish_date = datetime.now()

        categories = re.split('；|;', request.form['categories'])  # 使用中文和英文的分号分隔用户输入的类别
        tags = re.split('；|;', request.form['tags'])  # 使用中文和英文的分号分隔用户输入的标签

        blog = Blogs(title=title, content=content, author_id=author_id, publish_date=publish_date)
        db.session.add(blog)
        db.session.commit()

        for category_name in categories:
            category = Categories.query.filter_by(name=category_name).first()
            if category is None:
                category = Categories(name=category_name)
                db.session.add(category)
                db.session.commit()
            blog_category = BlogCategories(blog_id=blog.blog_id, category_id=category.category_id)
            db.session.add(blog_category)
            db.session.commit()

        for tag_name in tags:
            tag = Tags.query.filter_by(name=tag_name).first()
            if tag is None:
                tag = Tags(name=tag_name)
                db.session.add(tag)
                db.session.commit()
            blog_tag = BlogTags(blog_id=blog.blog_id, tag_id=tag.tag_id)
            db.session.add(blog_tag)
            db.session.commit()

        return redirect(url_for('home'))

    return render_template('./blog/new_blog.html')

@app.route('/new-comment/<int:blog_id>', methods=['POST'])
def new_comment(blog_id):
    # 检查用户是否已登录
    commenter_id = session.get('user_id')  # 假设评论者 ID 是通过会话获取的
    if not commenter_id:
        flash('请先登录')
        return redirect(url_for('login'))  # 假设你有一个名为 'login' 的路由处理登录

    content = request.form['content']
    parent_id = request.form.get('parent_id')  # 获取被回复的评论的 ID

    # 检查是否试图回复自己的评论
    if parent_id:
        parent_comment = Comments.query.get(parent_id)
        if parent_comment and parent_comment.commenter_id == commenter_id:
            flash('你不能回复自己的评论!')  # 使用 flash 函数存储错误信息
            return redirect(url_for('blog', blog_id=blog_id))

    comment = Comments(content=content, commenter_id=commenter_id, blog_id=blog_id, parent_id=parent_id)
    db.session.add(comment)
    db.session.commit()

    return redirect(url_for('blog', blog_id=blog_id))

@app.route('/category/<int:category_id>')
def category(category_id):
    blogs = Blogs.query.join(BlogCategories).filter(BlogCategories.category_id == category_id).all()  # 获取该分类下的所有博客
    return render_template('category.html', blogs=blogs)

@app.route('/tag/<int:tag_id>')
def tag(tag_id):
    blogs = Blogs.query.join(BlogTags).filter(BlogTags.tag_id == tag_id).all()  # 获取该标签下的所有博客
    return render_template('tag.html', blogs=blogs)

@app.route('/search')
def search():
    keyword = request.args.get('keyword')  # 获取搜索关键词
    if not keyword:
        return "Error: No keyword provided.", 400

    # 搜索标题、内容、类别或标签包含关键词的博客
    blogs = Blogs.query\
    .join(Blogs.categories)\
    .join(Blogs.tags)\
    .filter((Blogs.title.contains(keyword)) | (Blogs.content.contains(keyword)) | (Categories.name.contains(keyword)) | (Tags.name.contains(keyword)))\
    .all()

    if not blogs:
        return "Error: No blogs found with the given keyword.", 404
    return render_template('./home/search.html', blogs=blogs)



@app.route('/my-blogs')
def my_blogs():
    user_id = session['user_id']  # 假设用户 ID 是通过会话获取的
    blogs = Blogs.query.filter_by(author_id=user_id).all()  # 获取该用户的所有博客
    return render_template('./my_blogs/my_blogs.html', blogs=blogs)

@app.route('/edit-blog/<int:blog_id>', methods=['GET', 'POST'])
def edit_blog(blog_id):
    blog_view = db.session.execute(text(f"SELECT * FROM BlogView WHERE blog_id = {blog_id}"))
    blog_view = [dict(row._mapping) for row in blog_view]
    blog = db.session.get(Blogs, blog_id)  # 获取指定 ID 的博客
    if request.method == 'POST':
        blog.title = request.form['title']
        blog.content = request.form['content']

        categories = re.split('；|;', request.form['categories'])  # 使用中文和英文的分号分隔用户输入的类别
        tags = re.split('；|;', request.form['tags'])  # 使用中文和英文的分号分隔用户输入的标签

        # 更新博客的类别
        BlogCategories.query.filter_by(blog_id=blog.blog_id).delete()
        for category_name in categories:
            category = Categories.query.filter_by(name=category_name).first()
            if category is None:
                category = Categories(name=category_name)
                db.session.add(category)
                db.session.commit()
            blog_category = BlogCategories(blog_id=blog.blog_id, category_id=category.category_id)
            db.session.add(blog_category)
            db.session.commit()

        # 更新博客的标签
        BlogTags.query.filter_by(blog_id=blog.blog_id).delete()
        for tag_name in tags:
            tag = Tags.query.filter_by(name=tag_name).first()
            if tag is None:
                tag = Tags(name=tag_name)
                db.session.add(tag)
                db.session.commit()
            blog_tag = BlogTags(blog_id=blog.blog_id, tag_id=tag.tag_id)
            db.session.add(blog_tag)
            db.session.commit()

        db.session.commit()
        return redirect(url_for('my_blogs'))

    return render_template('./my_blogs/edit_blog.html', blog_view=blog_view)


@app.route('/delete-blog/<int:blog_id>', methods=['POST'])
def delete_blog(blog_id):
    blog = db.session.get(Blogs, blog_id)
    # 删除所有与这个博客相关的 BlogCategories 记录
    BlogCategories.query.filter_by(blog_id=blog_id).delete()
    # 删除所有与这个博客相关的 BlogTags 记录
    BlogTags.query.filter_by(blog_id=blog_id).delete()
    # 删除所有与这个博客相关的 Comments 记录
    Comments.query.filter_by(blog_id=blog_id).delete()
    # 删除所有与这个博客相关的votes 记录
    UserVotes.query.filter_by(blog_id=blog_id).delete()
    # 现在可以安全地删除这个博客了
    db.session.delete(blog)
    db.session.commit()
    return redirect(url_for('my_blogs'))

@app.route('/admin')
def admin_home():
    return render_template('./admin/admin.html')

@app.route('/admin_login', methods=['GET', 'POST'])
def admin_login():
    error = None
    if request.method == 'POST':
        adminname = request.form['adminname']
        password = request.form['password']  # 获取密码
        # 还需要验证输入

        admin = Admins.query.filter_by(username=adminname).first()
        if admin is None:
            error = '管理员不存在。'
        elif admin.password != password:  # 假设密码是明文存储的
            error = '密码错误。请重新输入。'
        else:
            session['admin_id'] = admin.admin_id  # 将管理员 ID 存储在会话中，表示管理员已登录
            session['adminname'] = admin.username
            return redirect(url_for('admin_home'))

    return render_template('./admin/admin_login.html', error=error)

@app.route('/admin/users')
def admin_users():
    # 调用存储过程
    result = db.session.execute(text('CALL GetUserCount();'))
    user_count = result.fetchone()[0]

    # 获取所有用户的信息
    users = Users.query.all()

    return render_template('./admin/users.html', users=users, user_count=user_count)

@app.route('/toggle_user/<int:user_id>', methods=['POST'])
def toggle_user(user_id):
    user = db.session.get(Users, user_id)
    if user is not None:
        user.is_disabled = not user.is_disabled
        db.session.commit()
        flash('用户状态已更新。')
    else:
        flash('用户不存在。')

    return redirect(url_for('admin_users'))

@app.route('/delete_user/<int:user_id>', methods=['POST'])
def delete_user(user_id):
    user = db.session.get(Users, user_id)
    if user is not None:
        # 删除所有与这个用户相关的 Comments 记录
        Comments.query.filter_by(commenter_id=user_id).delete()
        # 获取该用户的所有博客
        user_blogs = Blogs.query.filter_by(author_id=user.user_id).all()
        # 删除和这个用户相关的所有投票记录
        UserVotes.query.filter_by(user_id=user_id).delete()
        # 现在可以安全地删除这个博客了
        for blog in user_blogs:
            # 删除博客相关的 BlogCategories、BlogTags 和 Comments 记录
            delete_blog(blog.blog_id)
        # 删除用户
        db.session.delete(user)
        db.session.commit()
        flash('用户及其所有博客已被删除。')
    else:
        flash('用户不存在。')

    return redirect(url_for('admin_users'))


@app.route('/admin/blogs')
def admin_blogs():
    # 获取所有用户及其博客的信息
    users = Users.query.options(db.joinedload(Users.blogs)).all()
    # 获取每个用户的博客数量
    for user in users:
        result = db.session.execute(text('CALL GetUserBlogCount(:user_id);'), {'user_id': user.user_id})
        user.blog_count = result.fetchone()[0]
    # 获取所有博客数量
    result = db.session.execute(text('CALL GetAllBlogCount();'))
    blog_count = result.fetchone()[0]
    # 获取每个博客的点赞数和反赞数
    blog_votes = {blog.blog_id: {'upvotes': UserVotes.query.filter_by(blog_id=blog.blog_id, vote=1).count(),
                                 'downvotes': UserVotes.query.filter_by(blog_id=blog.blog_id, vote=-1).count()}
                  for user in users for blog in user.blogs}
    # 创建一个新的列表，这个列表的元素是用户和他们的博客数
    sorted_users = sorted(users, key=lambda user: user.blog_count, reverse=True)
    return render_template('admin/admin_blogs.html', users=sorted_users, blog_votes=blog_votes,blog_count=blog_count)


@app.route('/show_blog/<int:blog_id>')
def show_blog(blog_id):
    # 获取指定 ID 的博客以及其作者
    blog = db.session.query(Blogs, Users).join(Users, Blogs.author_id == Users.user_id).filter(Blogs.blog_id == blog_id).first()
    comments = Comments.query.filter_by(blog_id=blog_id).all()  # 获取该博客的所有评论

    # 获取该博客的所有类别和标签
    categories = Categories.query.join(BlogCategories).filter(BlogCategories.blog_id == blog_id).all()
    tags = Tags.query.join(BlogTags).filter(BlogTags.blog_id == blog_id).all()

    # 获取该博客的点赞数和反赞数
    upvotes = UserVotes.query.filter_by(blog_id=blog_id, vote=1).count()
    downvotes = UserVotes.query.filter_by(blog_id=blog_id, vote=-1).count()

    error_messages = get_flashed_messages()  # 获取可能存在的错误信息
    error = error_messages[0] if error_messages else None  # 从列表中取出错误信息
    error = error.replace('"', '') if error else None  # 去掉引号

    if error:  # 如果有错误信息
        return render_template('./admin/blog.html', blog=blog.Blogs, author=blog.Users, comments=comments, categories=categories, tags=tags, upvotes=upvotes, downvotes=downvotes, error=error)
    else:  # 如果没有错误信息
        return render_template('./admin/blog.html', blog=blog.Blogs, author=blog.Users, comments=comments, categories=categories, tags=tags, upvotes=upvotes, downvotes=downvotes)

@app.route('/admin/admin_delete_blog/<int:blog_id>', methods=['POST'])
def admin_delete_blog(blog_id):
    blog = Blogs.query.get(blog_id)  # 获取指定 ID 的博客
    if blog is None:
        return "Error: No blog found with the given ID.", 404
    else:
        # 删除所有与这个博客相关的 BlogCategories 记录
        BlogCategories.query.filter_by(blog_id=blog_id).delete()
        # 删除所有与这个博客相关的 BlogTags 记录
        BlogTags.query.filter_by(blog_id=blog_id).delete()
        # 删除所有与这个博客相关的 Comments 记录
        Comments.query.filter_by(blog_id=blog_id).delete()
        # 现在可以安全地删除这个博客了
        db.session.delete(blog)
        db.session.commit()
    return redirect(url_for('admin_blogs', message='博客已被删除。'))

@app.route('/admin/comments')
def admin_comments():
    # 获取所有评论的信息，包括用户名、评论内容和博客标题
    comments = list(db.session.execute(text(f"SELECT * FROM UserBlogCommentsView")))
    # 获取每个用户的评论数量
    user_comment_counts = db.session.execute(text('CALL GetUserCommentCount();')).fetchall()
    user_comment_counts = {row[0]: row[1] for row in user_comment_counts}
    # 获取所有评论数量
    result = db.session.execute(text('CALL GetAllCommentCount();'))
    comment_count = result.fetchone()[0]
    # 按照评论数量对用户名进行排序
    sorted_usernames = sorted(user_comment_counts.items(), key=lambda x: x[1], reverse=True)
    # 创建一个新的字典，其中键是用户名，值是该用户的所有评论
    user_comments_dict = {username: [comment for comment in comments if comment.username == username] for username, _ in sorted_usernames}
    return render_template('admin/comments.html', user_comments_dict=user_comments_dict, user_comment_counts=user_comment_counts, comment_count=comment_count, sorted_usernames=sorted_usernames)

@app.route('/admin/admin_delete_comment/<int:comment_id>', methods=['POST'])
def admin_delete_comment(comment_id):
    comment = Comments.query.get(comment_id)  # 获取指定 ID 的评论
    if comment is not None:
        db.session.delete(comment)
        db.session.commit()

    return redirect(url_for('admin_comments'))


from itertools import groupby

@app.route('/admin/categories')
def admin_categories():
    # 获取所有类别的信息
    categories = db.session.execute(text("SELECT DISTINCT blog_id, title, content, author_id, publish_date, category_id, category_name FROM BlogView"))
    categories = sorted(list(categories), key=lambda x: x.category_name)
    # 获取类别总数
    result = db.session.execute(text('CALL GetCategoryCount();'))
    category_count = result.fetchone()[0]
    # 获取每个类别下的博客数
    result = db.session.execute(text('CALL GetBlogCountByCategory();'))
    blog_count_by_category = {row[0]: row[1] for row in result.fetchall()}
    # 创建一个新的字典，其中键是类别名称，值是一个包含类别名称和博客数的字典
    categories_with_counts = {category_name: {'category_blogs': list(category_blogs), 'blog_count': blog_count_by_category[category_name]} for category_name, category_blogs in groupby(categories, key=lambda x: x.category_name)}
    # 对字典进行排序
    categories_with_counts = dict(sorted(categories_with_counts.items(), key=lambda item: item[1]['blog_count'], reverse=True))
    return render_template('./admin/categories.html', categories_with_counts=categories_with_counts, category_count=category_count)

@app.route('/admin/admin_delete_category/<int:category_id>', methods=['POST'])
def admin_delete_category(category_id):
    category = Categories.query.get(category_id)  # 获取指定 ID 的类别
    if category is not None:
        # 删除类别下的所有博客
        blogs = Blogs.query.join(BlogCategories).filter(BlogCategories.category_id==category_id).all()
        for blog in blogs:
            db.session.delete(blog)
        # 删除类别
        db.session.delete(category)
        db.session.commit()

    return redirect(url_for('admin_categories'))

@app.route('/admin/tags')
def admin_tags():
    # 获取所有标签的信息
    tags = db.session.execute(text("SELECT DISTINCT blog_id, title, content, author_id, publish_date, tag_id, tag_name FROM BlogView"))
    tags = sorted(list(tags), key=lambda x: x.tag_name)
    # 获取标签总数
    result = db.session.execute(text('CALL GetTagCount();'))
    tag_count = result.fetchone()[0]
    # 获取每个标签下的博客数
    result = db.session.execute(text('CALL GetBlogCountByTag();'))
    blog_count_by_tag = {row[0]: row[1] for row in result.fetchall()}
    # 创建一个新的字典，其中键是标签名称，值是一个包含标签名称和博客数的字典
    tags_with_counts = {tag_name: {'tag_blogs': list(tag_blogs), 'blog_count': blog_count_by_tag[tag_name]} for tag_name, tag_blogs in groupby(tags, key=lambda x: x.tag_name)}
    # 对字典进行排序
    tags_with_counts = dict(sorted(tags_with_counts.items(), key=lambda item: item[1]['blog_count'], reverse=True))
    return render_template('./admin/tags.html', tags_with_counts=tags_with_counts, tag_count=tag_count)

@app.route('/admin/admin_delete_tag/<int:tag_id>', methods=['POST'])
def admin_delete_tag(tag_id):
    tag = Tags.query.get(tag_id)  # 获取指定 ID 的标签
    if tag is not None:
        # 删除标签下的所有博客
        blogs = Blogs.query.join(BlogTags).filter(BlogTags.tag_id==tag_id).all()
        for blog in blogs:
            db.session.delete(blog)
        # 删除标签
        db.session.delete(tag)
        db.session.commit()

    return redirect(url_for('admin_tags'))

@app.route('/admin/admin_announcements')
def admin_announcements():
    # 获取所有公告的信息
    announcements = db.session.execute(text("SELECT * FROM AnnouncementAdminView"))
    announcements = [dict(row._mapping) for row in announcements]
    # 获取公告总数
    result = db.session.execute(text('CALL GetAnnouncementCount();'))
    announcement_count = result.fetchone()[0]
    return render_template('./admin/admin_announcements.html', announcements=announcements, announcement_count=announcement_count)


@app.route('/show_announcement/<int:announcement_id>')
def show_announcement(announcement_id):
    # 显示一个公告
    announcement = db.session.execute(text(f"SELECT * FROM AnnouncementAdminView WHERE announcement_id = {announcement_id}"))
    announcement = [dict(row._mapping) for row in announcement][0]
    return render_template('./admin/show_announcement.html', announcement=announcement)

@app.route('/admin/new_announcements', methods=['GET', 'POST'])
def new_announcements():
    # 发布一个新公告
    if request.method == 'POST':
        title = request.form['title']
        content = request.form['content']
        admin_id = session['admin_id']  # 假设管理员的 ID 存储在 session 中
        publish_date = datetime.now()  # 使用当前日期作为发布日期
        new_announcement = Announcements(title=title, content=content, admin_id=admin_id, publish_date=publish_date)
        db.session.add(new_announcement)
        db.session.commit()
        return redirect(url_for('admin_announcements'))
    return render_template('./admin/new_announcements.html')


@app.route('/admin/edit_announcement/<int:announcement_id>', methods=['GET', 'POST'])
def edit_announcement(announcement_id):
    #对一个已经发布的公告进行编辑
    announcement = Announcements.query.get_or_404(announcement_id)
    if request.method == 'POST':
        announcement.title = request.form['title']
        announcement.content = request.form['content']
        db.session.commit()
        return redirect(url_for('show_announcement', announcement_id=announcement_id))
    return render_template('./admin/edit_announcement.html', announcement=announcement)

@app.route('/admin/announcements/<int:announcement_id>/delete', methods=['POST'])
def admin_announcement_delete(announcement_id):
    #对一个公告进行删除
    announcement = Announcements.query.get_or_404(announcement_id)
    db.session.delete(announcement)
    db.session.commit()
    return redirect(url_for('admin_announcements'))



if __name__ == '__main__':
    app.run(debug=True)
