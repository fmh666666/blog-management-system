/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80100
 Source Host           : localhost:3306
 Source Schema         : blog_management

 Target Server Type    : MySQL
 Target Server Version : 80100
 File Encoding         : 65001

 Date: 07/12/2023 17:57:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admins
-- ----------------------------
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins`  (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `email` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`admin_id`) USING BTREE,
  INDEX `idx_username`(`username` ASC) USING BTREE,
  INDEX `idx_email`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admins
-- ----------------------------
INSERT INTO `admins` VALUES (2, 'fmh', 'fmh123', '123.com');

-- ----------------------------
-- Table structure for announcements
-- ----------------------------
DROP TABLE IF EXISTS `announcements`;
CREATE TABLE `announcements`  (
  `announcement_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `admin_id` int NULL DEFAULT NULL,
  `publish_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`announcement_id`) USING BTREE,
  INDEX `idx_title`(`title` ASC) USING BTREE,
  INDEX `idx_admin_id`(`admin_id` ASC) USING BTREE,
  CONSTRAINT `announcements_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`admin_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of announcements
-- ----------------------------
INSERT INTO `announcements` VALUES (2, '博客平台第一公告', '大家好，欢迎来到我们的博客！\r\n\r\n我们的博客将会分享各种有趣的内容，包括但不限于技术文章、生活感悟、旅行日记等。我们希望通过这个平台，与大家分享我们的知识和经验，也希望能从大家那里学到新的东西。\r\n\r\n在这里，你可以：\r\n\r\n* 阅读我们的博客文章\r\n* 对文章进行评论\r\n* 给你喜欢的文章点赞\r\n* 与我们的作者进行互动\r\n\r\n我们非常期待你的参与，一起在知识的海洋中探索和学习。如果你有任何问题或建议，欢迎随时向我们提出。\r\n\r\n再次感谢你的关注和支持，让我们一起开始这个精彩的旅程吧！', 2, '2023-11-28');

-- ----------------------------
-- Table structure for blog_categories
-- ----------------------------
DROP TABLE IF EXISTS `blog_categories`;
CREATE TABLE `blog_categories`  (
  `relation_id` int NOT NULL AUTO_INCREMENT,
  `blog_id` int NULL DEFAULT NULL,
  `category_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`relation_id`) USING BTREE,
  INDEX `idx_blog_id`(`blog_id` ASC) USING BTREE,
  INDEX `idx_category_id`(`category_id` ASC) USING BTREE,
  CONSTRAINT `blog_categories_ibfk_1` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`blog_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `blog_categories_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 114 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of blog_categories
-- ----------------------------
INSERT INTO `blog_categories` VALUES (22, 20, 14);
INSERT INTO `blog_categories` VALUES (23, 20, 15);
INSERT INTO `blog_categories` VALUES (24, 21, 14);
INSERT INTO `blog_categories` VALUES (25, 21, 15);
INSERT INTO `blog_categories` VALUES (26, 22, 14);
INSERT INTO `blog_categories` VALUES (27, 22, 15);
INSERT INTO `blog_categories` VALUES (28, 23, 14);
INSERT INTO `blog_categories` VALUES (29, 23, 15);
INSERT INTO `blog_categories` VALUES (42, 31, 14);
INSERT INTO `blog_categories` VALUES (43, 31, 14);
INSERT INTO `blog_categories` VALUES (44, 31, 21);
INSERT INTO `blog_categories` VALUES (45, 31, 21);
INSERT INTO `blog_categories` VALUES (46, 32, 14);
INSERT INTO `blog_categories` VALUES (47, 32, 22);
INSERT INTO `blog_categories` VALUES (48, 32, 23);
INSERT INTO `blog_categories` VALUES (49, 33, 14);
INSERT INTO `blog_categories` VALUES (50, 33, 24);
INSERT INTO `blog_categories` VALUES (51, 33, 25);
INSERT INTO `blog_categories` VALUES (52, 34, 14);
INSERT INTO `blog_categories` VALUES (53, 34, 24);
INSERT INTO `blog_categories` VALUES (54, 34, 25);
INSERT INTO `blog_categories` VALUES (55, 35, 14);
INSERT INTO `blog_categories` VALUES (56, 35, 24);
INSERT INTO `blog_categories` VALUES (57, 35, 25);
INSERT INTO `blog_categories` VALUES (58, 30, 14);
INSERT INTO `blog_categories` VALUES (59, 30, 14);
INSERT INTO `blog_categories` VALUES (60, 30, 21);
INSERT INTO `blog_categories` VALUES (61, 30, 21);
INSERT INTO `blog_categories` VALUES (71, 36, 14);
INSERT INTO `blog_categories` VALUES (72, 36, 24);
INSERT INTO `blog_categories` VALUES (73, 36, 28);
INSERT INTO `blog_categories` VALUES (74, 37, 14);
INSERT INTO `blog_categories` VALUES (75, 37, 24);
INSERT INTO `blog_categories` VALUES (76, 37, 25);
INSERT INTO `blog_categories` VALUES (77, 38, 14);
INSERT INTO `blog_categories` VALUES (78, 38, 22);
INSERT INTO `blog_categories` VALUES (79, 38, 24);
INSERT INTO `blog_categories` VALUES (81, 39, 14);
INSERT INTO `blog_categories` VALUES (82, 39, 24);
INSERT INTO `blog_categories` VALUES (83, 39, 23);
INSERT INTO `blog_categories` VALUES (84, 39, 22);
INSERT INTO `blog_categories` VALUES (85, 40, 14);
INSERT INTO `blog_categories` VALUES (86, 40, 24);
INSERT INTO `blog_categories` VALUES (87, 40, 22);
INSERT INTO `blog_categories` VALUES (88, 41, 23);
INSERT INTO `blog_categories` VALUES (89, 41, 22);
INSERT INTO `blog_categories` VALUES (90, 41, 24);
INSERT INTO `blog_categories` VALUES (91, 42, 22);
INSERT INTO `blog_categories` VALUES (92, 42, 24);
INSERT INTO `blog_categories` VALUES (93, 42, 23);
INSERT INTO `blog_categories` VALUES (94, 42, 14);
INSERT INTO `blog_categories` VALUES (111, 29, 14);
INSERT INTO `blog_categories` VALUES (112, 29, 14);

-- ----------------------------
-- Table structure for blog_tags
-- ----------------------------
DROP TABLE IF EXISTS `blog_tags`;
CREATE TABLE `blog_tags`  (
  `relation_id` int NOT NULL AUTO_INCREMENT,
  `blog_id` int NULL DEFAULT NULL,
  `tag_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`relation_id`) USING BTREE,
  INDEX `idx_blog_id`(`blog_id` ASC) USING BTREE,
  INDEX `idx_tag_id`(`tag_id` ASC) USING BTREE,
  CONSTRAINT `blog_tags_ibfk_1` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`blog_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `blog_tags_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 86 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of blog_tags
-- ----------------------------
INSERT INTO `blog_tags` VALUES (16, 20, 14);
INSERT INTO `blog_tags` VALUES (17, 21, 14);
INSERT INTO `blog_tags` VALUES (18, 22, 14);
INSERT INTO `blog_tags` VALUES (19, 23, 14);
INSERT INTO `blog_tags` VALUES (32, 31, 19);
INSERT INTO `blog_tags` VALUES (33, 31, 20);
INSERT INTO `blog_tags` VALUES (36, 32, 21);
INSERT INTO `blog_tags` VALUES (37, 33, 22);
INSERT INTO `blog_tags` VALUES (38, 33, 23);
INSERT INTO `blog_tags` VALUES (39, 34, 22);
INSERT INTO `blog_tags` VALUES (40, 34, 23);
INSERT INTO `blog_tags` VALUES (41, 35, 22);
INSERT INTO `blog_tags` VALUES (42, 35, 23);
INSERT INTO `blog_tags` VALUES (44, 30, 20);
INSERT INTO `blog_tags` VALUES (45, 30, 19);
INSERT INTO `blog_tags` VALUES (55, 36, 28);
INSERT INTO `blog_tags` VALUES (56, 36, 29);
INSERT INTO `blog_tags` VALUES (57, 37, 30);
INSERT INTO `blog_tags` VALUES (58, 38, 30);
INSERT INTO `blog_tags` VALUES (60, 39, 30);
INSERT INTO `blog_tags` VALUES (61, 40, 31);
INSERT INTO `blog_tags` VALUES (62, 40, 32);
INSERT INTO `blog_tags` VALUES (63, 41, 31);
INSERT INTO `blog_tags` VALUES (64, 41, 32);
INSERT INTO `blog_tags` VALUES (65, 42, 31);
INSERT INTO `blog_tags` VALUES (66, 42, 32);
INSERT INTO `blog_tags` VALUES (83, 29, 19);
INSERT INTO `blog_tags` VALUES (84, 29, 20);

-- ----------------------------
-- Table structure for blogs
-- ----------------------------
DROP TABLE IF EXISTS `blogs`;
CREATE TABLE `blogs`  (
  `blog_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `author_id` int NULL DEFAULT NULL,
  `publish_date` date NULL DEFAULT NULL,
  `upvotes` int NULL DEFAULT 0,
  `downvotes` int NULL DEFAULT 0,
  PRIMARY KEY (`blog_id`) USING BTREE,
  INDEX `idx_title`(`title` ASC) USING BTREE,
  INDEX `idx_author_id`(`author_id` ASC) USING BTREE,
  INDEX `idx_publish_date`(`publish_date` ASC) USING BTREE,
  CONSTRAINT `blogs_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 75 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of blogs
-- ----------------------------
INSERT INTO `blogs` VALUES (20, 'MySQL 管理', '## MySQL 管理\r\n\r\n1. 启动及关闭 MySQL 服务器\r\n\r\n    Windows 系统下\r\n\r\n    在 Windows 系统下，打开命令窗口(cmd)，进入 MySQL 安装目录的 bin 目录。\r\n\r\n    启动：\r\n\r\n    ```bash\r\n    cd c:/mysql/bin\r\n    mysqld --console\r\n    ```\r\n\r\n    关闭：\r\n\r\n    ```bash\r\n    cd c:/mysql/bin\r\n    mysqladmin -u root   shutdown\r\n    ```\r\n\r\n2. MySQL 用户设置\r\n\r\n    修改密码：\r\n\r\n    ```bash\r\n    ALTER USER \'root\'@\'localhost\' IDENTIFIED BY \'123456\';\r\n    ```\r\n\r\n    BY后面跟上要修改的密码\r\n\r\n## Navicat Premium 连接\r\n\r\n1. 下载好Navicat Premiun\r\n2. 创建连接\r\n\r\n    点击连接,选择MySQL\r\n\r\n    自定义连接名，输入密码\r\n\r\n    密码为系统当时生成的密码，如果想要用现在登录root的密码去连接，需要如下设置\r\n\r\n    ```sql\r\n    ALTER USER \'root\'@\'localhost\' IDENTIFIED BY \'password\' PASSWORD EXPIRE NEVER; \r\n    ALTER USER \'root\'@\'localhost\' IDENTIFIED WITH mysql_native_password BY \'[password]\'; \r\n    FLUSH PRIVILEGES; \r\n    ```\r\n\r\n    `password`:为自己设置登录root和Navicat Premium 连接的密码。\r\n\r\n3. 操作\r\n\r\n\r\n    点击命令列界面就可以进入类似命名行进行操作\r\n\r\n    点击新建查询就可以用脚本化的sql语句进行进行操作\r\n', 5, '2023-11-27', 2, 2);
INSERT INTO `blogs` VALUES (21, 'MySQL 创建数据库', '## MySQL 创建数据库\r\n\r\n1. 我们可以在登陆 MySQL 服务后，使用 create 命令创建数据库，语法如下:\r\n\r\n    ```sql\r\n    CREATE DATABASE 数据库名;\r\n    ```\r\n\r\n    以下命令简单的演示了创建数据库的过程，数据名为SATAN:\r\n\r\n    ```sql\r\n    [root@host]# mysql  -u root -p   \r\n    Enter   password:******  #    登录后进入终端\r\n\r\n    mysql> CREATE DATABASE STATAN;\r\n    ```\r\n\r\n2. 使用 mysqladmin 创建数据库\r\n\r\n    使用普通用户，你可能需要特定的权限来创建或者删除 MySQL数据库。\r\n\r\n    所以我们这边使用root用户登录，root用户拥有最高权限，可以使用   mysql `mysqladmin` 命令来创建数据库。\r\n\r\n    以下命令简单的演示了创建数据库的过程，数据名为 STATAN:\r\n\r\n    ```sql\r\n    [root@host]# mysqladmin -u root -p create STATAN\r\n    Enter password:******\r\n   ', 5, '2023-11-27', 0, 0);
INSERT INTO `blogs` VALUES (22, 'MySQL 数据类型', '## MySQL 数据类型\r\n\r\nMySQL 中定义数据字段的类型对你数据库的优化是非常重要的。\r\n\r\nMySQL 支持多种类型，大致可以分为三类：数值、日期/时间和字符串(字符)类型。\r\n\r\n1. 数值类型\r\n\r\n    MySQL 支持所有标准 SQL 数值数据类型。\r\n\r\n    这些类型包括严格数值数据类型(INTEGER、SMALLINT、DECIMAL 和 NUMERIC)，以及近似数值数据类型(FLOAT、REAL 和 DOUBLE PRECISION)。\r\n\r\n    关键字INT是INTEGER的同义词，关键字DEC是DECIMAL的同义词。\r\n\r\n    BIT数据类型保存位字段值，并且支持 MyISAM、MEMORY、InnoDB 和 BDB表。\r\n\r\n    作为 SQL 标准的扩展，MySQL 也支持整数类型 TINYINT、MEDIUMINT 和 BIGINT。下面的表显示了需要的每个整数类型的存储和范围。\r\n\r\n\r\n2. 日期和时间类型\r\n\r\n    表示时间值的日期和时间类型为DATETIME、DATE、TIMESTAMP、TIME和YEAR。\r\n\r\n    每个时间类型有一个有效值范围和一个\"零\"值，当指定不合法的MySQL不能表示的值时使用\"零\"值。\r\n\r\n    TIMESTAMP类型有专有的自动更新特性，将在后面描述。\r\n\r\n\r\n3. 字符串类型\r\n\r\n    字符串类型指CHAR、VARCHAR、BINARY、VARBINARY、BLOB、TEXT、ENUM和SET。该节描述了这些类型如何工作以及如何在查询中使用这些类型。\r\n\r\n\r\n    注意：char(n) 和 varchar(n) 中括号中 n 代表字符的个数，并不代表字节个数，比如 CHAR(30) 就可以存储 30 个字符，一个英文字母占用一个字符，一个汉字占用两个字符。\r\n\r\n    CHAR 和 VARCHAR 类型类似，但它们保存和检索的方式不同。它们的最大长度和是否尾部空格被保留等方面也不同。在存储或检索过程中不进行大小写转换。\r\n\r\n    BINARY 和 VARBINARY 类似于 CHAR 和 VARCHAR，不同的是它们包含二进制字符串而不要非二进制字符串。也就是说，它们包含字节字符串而不是字符字符串。这说明它们没有字符集，并且排序和比较基于列值字节的数值值。\r\n\r\n    BLOB 是一个二进制大对象，可以容纳可变数量的数据。有 4 种 BLOB 类型：TINYBLOB、BLOB、MEDIUMBLOB 和 LONGBLOB。它们区别在于可容纳存储范围不同。\r\n\r\n    有 4 种 TEXT 类型：TINYTEXT、TEXT、MEDIUMTEXT 和 LONGTEXT。对应的这 4 种 BLOB 类型，可存储的最大长度不同，可根据实际情况选择。\r\n', 5, '2023-11-27', 0, 0);
INSERT INTO `blogs` VALUES (23, 'MySQL 查询数据', '## MySQL 查询数据\r\n\r\nMySQL 数据库使用SQL SELECT语句来查询数据。\r\n\r\n你可以通过 mysql> 命令提示窗口中在数据库中查询数据，或者通过PHP脚本来查询数据。\r\n\r\n1. 语法\r\n\r\n    以下为在MySQL数据库中查询数据通用的 SELECT 语法：\r\n\r\n    ```sql\r\n    SELECT column_name,column_name\r\n    FROM table_name\r\n    [WHERE Clause]\r\n    [LIMIT N][ OFFSET M]\r\n    ```\r\n\r\n    * 查询语句中你可以使用一个或者多个表，表之间使用逗号(,)分割，并使用WHERE语句来设定查询条件。\r\n    * SELECT 命令可以读取一条或者多条记录。\r\n    * 你可以使用星号（*）来代替其他字段，SELECT语句会返回表的所有字段数据\r\n    * 你可以使用 WHERE 语句来包含任何条件。\r\n    * 你可以使用 LIMIT 属性来设定返回的记录数。\r\n    * 你可以通过OFFSET指定SELECT语句开始查询的数据偏移量。默认情况下偏移量为0。\r\n\r\n2. 通过命令提示符获取数据\r\n\r\n    以下实例我们将通过 SQL SELECT 命令来获取 MySQL 数据表 satan_tbl 的数据：\r\n\r\n    **实例**\r\n\r\n    以下实例将返回数据表 satan_tbl 的所有记录:\r\n\r\n    ```sql\r\n    SELECT * FROM satan_tbl;\r\n    ```\r\n', 5, '2023-11-27', 0, 0);
INSERT INTO `blogs` VALUES (29, 'Flask入门2', '## URL 构建\r\n\r\n`url_for()` 函数用于构建指定函数的 URL。它把函数名称作为第一个 参数。它可以接受任意个关键字参数，每个关键字参数对应 URL 中的变量。未知变量 将添加到 URL 中作为查询参数。\r\n\r\n为什么不在把 URL 写死在模板中，而要使用反转函数 url_for() 动态构建？\r\n\r\n1. 反转通常比硬编码 URL 的描述性更好。\r\n2. 你可以只在一个地方改变 URL ，而不用到处乱找。\r\n3. URL 创建会为你处理特殊字符的转义和 Unicode 数据，比较直观。\r\n4. 生产的路径总是绝对路径，可以避免相对路径产生副作用。\r\n5. 如果你的应用是放在 URL 根路径之外的地方（如在 `/myapplication` 中，不在 `/` 中）， `url_for()` 会为你妥善处理。\r\n\r\n例如，这里我们使用 test_request_context() 方法来尝试使用 url_for() 。 test_request_context() 告诉 Flask 正在处理一个请求，而实际上也许我们正处在交互 Python shell 之中， 并没有真正的请求。\r\n\r\n```python\r\nfrom flask import Flask, escape, url_for\r\n\r\napp = Flask(__name__)\r\n\r\n@app.route(\'/\')\r\ndef index():\r\n    return \'index\'\r\n\r\n@app.route(\'/login\')\r\ndef login():\r\n    return \'login\'\r\n\r\n@app.route(\'/user/<username>\')\r\ndef profile(username):\r\n    return \'{}\\\'s profile\'.format(escape(username))\r\n\r\nwith app.test_request_context():\r\n    print(url_for(\'index\'))\r\n    print(url_for(\'login\'))\r\n    print(url_for(\'login\', next=\'/\'))\r\n    print(url_for(\'profile\', username=\'John Doe\'))\r\n```\r\n\r\n```bash\r\n/\r\n/login\r\n/login?next=/\r\n/user/John%20Doe\r\n```\r\n\r\n## HTTP 方法\r\n\r\n1. HTTP简介\r\n\r\n`HTTP` 协议是 `Hyper Text Transfer Protocol`（超文本传输协议）的缩写, 用于从万维网（World Wide Web）服务器传输超文本到本地浏览器的传送协议。\r\n\r\n`HTTP` 协议工作于客户端-服务端架构为上。浏览器作为 `HTTP` 客户端通过 `URL` 向 服务端发送请求，服务端根据接收到的请求 `URL`，向客户端发送响应信息。`HTTP` 请求-响应模型如下所示：\r\n\r\n2. HTTP 请求消息\r\n\r\n`HTTP` 协议是一个简单的请求-响应协议，它指定了客户端可能发送给服务器什么样的消息以及得到什么样的响应。请求和响应消息的头以 `ASCII` 码形式给出；而消息内容则具有一个类似 `MIME` 的格式。\r\n浏览器向 `Web` 服务器发出请求时，它向服务器传递了一个请求信息，`HTTP` 请求信息由 3 部分组成：\r\n\r\n* 请求行\r\n* 请求头\r\n* 请求正文\r\n\r\n以下是一个 HTTP 请求消息的例子：\r\n\r\n```bash\r\nGET / HTTP/1.1\r\nHost: www.imooc.com\r\nConnection: keep-alive\r\nUser-Agent: Mozilla/5.0 AppleWebKit/537.36 Chrome/81.0\r\nAccept: text/html,application/xml;image/webp,image/png,*/*;\r\n...\r\n省略\r\n...\r\n```\r\n\r\n第一行是请求行，用来说明请求方法，要访问的资源，以及所使用的 `HTTP` 版本。在这个例子中，请求方法是 `GET`，要访问的资源是 `/`，`HTTP` 版本是 `1.1`，表示要获取网站首页 `/`的内容。\r\n\r\n紧接着请求行之后的部分是请求头部，用来说明服务器要使用的附加信息。例如：Host 指出请求的主机名，这里是 `www.imooc.com`。\r\n\r\n请求头部之后是请求正文，在请求正文中可以添加任意的其他数据，这个例子的请求正文为空。', 6, '2023-11-28', 0, 0);
INSERT INTO `blogs` VALUES (30, 'Flask入门3', '4. Flask 中的 HTTP 方法\r\n\r\n上面我们已经大概了解了什么是 `HTTP` 协议，简单来说就是客户端与服务端用来通信的协议，`HTTP` 协议中规定和很多 `HTTP` 方法来让我们根据不同的需求向服务端发起请求。下面我们通过一个具体的例子，说明如何在 `Flask` 中使用不同的 `HTTP` 方法：\r\n\r\n```python\r\nfrom flask import Flask, request\r\napp = Flask(__name__)\r\n```\r\n\r\n首先，导入类 `flask.Flask` 和 `flask.request`，`request` 封装了请求消息，可以获取请求的各种参数。\r\n\r\n```python\r\n@app.route(\'/login\', methods = [\'GET\'])\r\ndef login():\r\n```\r\n\r\n定义处理路径 `/login` 的函数 `login`，装饰器 `@app.route(’/login’, methods = [‘GET’])` 表示使用 `GET` 方法处理路径 `/login` 的请求。\r\n\r\n函数 `login` 返回一段用于登录的 `HTML` 表单，表单包括 2 个字段: `name` 和 `password`。在第 4 行，指定使用 `POST` 方法提交表单给服务端的 `/check_login` 页面。\r\n\r\n```python\r\n@app.route(\'/check_login\', methods = [\'POST\'])\r\ndef check_login():\r\n    name = request.form[\'name\']\r\n    password = request.form[\'password\']\r\n    if name == \'guest\' and password == \'123\':\r\n        return \'Login succeed\'\r\n    else:\r\n        return \'Login failed\'\r\n```\r\n\r\n定义处理路径 `/check_login` 的函数 `check_login`，装饰器 `@app.route(’/check_login’, methods = [‘POST’])` 表示使用 `POST` 方法处理路径 `/check_login` 的请求。\r\n\r\n函数 `check_login` 根据请求的参数 `name` 和 `password` 是否正确，返回给用户相应的信息。在第 3 行，提取参数 `name` 的值，在第 4 行，提取参数 `password` 的值。如果 `name` 是 `guest`，`password` 是 `123`，则返回登录成功消息，否则返回登录失败消息。\r\n\r\n```python\r\nif __name__ == \'__main__\':\r\n    app.run()\r\n```\r\n\r\n调用 `app.run()` 运行程序。用户在浏览器中输入 `http://localhost:5000/login`，浏览器显示：\r\n\r\n用户输入正确的 `name` 和 `password` 后，浏览器跳转到页面 `http://localhost:5000/check_login`，显示：\r\n\r\n## URL 组成部分详解\r\n\r\nURL 是 Uniform Resource Locator 的简写，中文名叫统一资源定位符，用于表示服务端的各种资源，例如网页。本小节讲解组成 URL 的各个部分，并给出在 Flask 中如何提取组成 URL 的各个部分。\r\n\r\n1. URL 组成详解\r\n\r\n先来看一个我们经常见到的 URL 形式：\r\n\r\n```\r\nhttp://www.imooc.com/wiki/html5\r\n```\r\n\r\n上面这个 URL 由以下几部分组成：\r\n\r\n```\r\nscheme://host:port/path?key=value\r\n```\r\n\r\n* `scheme`：代表的是访问的协议，一般为 `http` 或者 `https`。例如，`https://www.baidu.com` 的协议是 `https`；\r\n* `host`：主机名、域名，例如，`https://www.baidu.com` 的 `host` 为 `www.baidu.com`；\r\n* `port`：端口号，`http` 协议默认使用 `80` 端口，`https` 协议默认使用 `443` 端口。通常情况下，使用默认值，不需要显式的写明端口号，例如，`https://www.baidu.com` 的端口是 `443`。某些情况下，可以显式的写明端口号，例如，`http://localhost:5000` 的端口号是 `5000`；\r\n* `path`：页面路径，例如：`http://www.imooc.com/wiki/html5` 的 `path` 是 `wiki/html5`；\r\n* `key=value`：查询字符串，例如：`https://www.baidu.com/s?wd=python`，查询字符串是 `wd=python`，查询字符串包括两部分：参数名和参数值，这个例子中，参数名是 `wd`，参数值是 `python`。\r\n', 6, '2023-11-28', 0, 0);
INSERT INTO `blogs` VALUES (31, 'Flask入门4', '## Flask 的 request 对象\r\n\r\n浏览器访问服务端时，向服务端发送请求。`Flask` 程序使用 `request` 对象描述请求信息，本小节介绍 request 对象的概念，以及它的重要属性：`form` 和 `args`，并对属性的使用给出一个例子。\r\n\r\n1. 简介\r\n\r\n浏览器访问服务端，需要将相应的数据发送给服务端，可能有如下场景：\r\n\r\n* 通过 `URL` 参数进行查询，浏览器需要将查询参数发送给服务端\r\n* 提交表单 `form` 进行查询，浏览器需要将表单 `form` 中的字段发送给服务端\r\n* 上传文件，浏览器需要将文件发送给服务端\r\n\r\n服务端收到将客户端发送的数据后，封装形成一个请求对象，在 `Flask` 中，请求对象是一个模块变量 `flask.request`，它包含了如下常用属性：\r\n\r\n|属性   |说明   |\r\n|---|---|\r\n|`method`   |当前的请求方法   |\r\n|`form`   |表单参数及其值的字典对象   |\r\n|`args`   |查询字符串的字典对象   |\r\n|`values`   |包含所有数据的字典对象   |\r\n|`json`   |如果 mimetype 是 application/json，这个参数将会解析 json 数据，如果不是则返回 None   |\r\n|`headers`   |http 协议头部   |\r\n|`cookies`   |cookie 名称和值的字典对象   |\r\n|`files`   |与上传文件有关的数据   |\r\n\r\n假设 `URL` 等于 `http://localhost/query?userId=123`，`request` 对象中与 `URL` 参数相关的属性如下\r\n\r\n|属性   |说明   |\r\n|---|---|\r\n|`url`   |`http://localhost/query?userId=123`   |\r\n|`base_url`   |`http://localhost/query`   |\r\n|`host`   |`localhost`   |\r\n|`host_url`   |`http://localhost/`   |\r\n|`path`   |`/query`   |\r\n|`full_path`   |`/query?userId=123`   |\r\n\r\n2. 获取 URL 相关参数\r\n\r\n本节编写一个 `Flask` 程序 `request-url.py`，打印 `request` 中和 `URL` 相关的属性：\r\n\r\n```python\r\nfrom flask import Flask\r\nfrom flask import request\r\napp = Flask(__name__)\r\n\r\ndef echo(key, value):\r\n    print(\'%-10s = %s\' % (key, value))\r\n\r\n@app.route(\'/query\')\r\ndef query():\r\n    echo(\'url\', request.url)\r\n    echo(\'base_url\', request.base_url)    \r\n    echo(\'host\', request.host)\r\n    echo(\'host_url\', request.host_url)\r\n    echo(\'path\', request.path)\r\n    echo(\'full_path\', request.full_path)\r\n    return \'hello\'\r\n\r\nif __name__ == \'__main__\':\r\n    app.run(port = 80)\r\n```\r\n\r\n在浏览器中输入 `http://localhost/query?userId=123`，程序在终端输出如下：\r\n\r\n```bash\r\nurl        = http://localhost/query?userId=123\r\nbase_url   = http://localhost/query\r\nhost       = localhost\r\nhost_url   = http://localhost/\r\npath       = /query\r\nfull_path  = /query?userId=123\r\n```\r\n\r\n3. 解析查询参数\r\n\r\n`request.args` 保存了 `URL` 中的查询参数，下面编写一个例子 `request-args.py` 解析 `URL` 中的查询参数：\r\n\r\n```python\r\nfrom flask import Flask, request\r\napp = Flask(__name__)\r\n\r\n@app.route(\'/query\')\r\ndef query():\r\n    print(\'name =\', request.args[\'name\'])\r\n    print(\'age =\', request.args[\'age\'])\r\n    return \'hello\'\r\n\r\nif __name__ == \'__main__\':\r\n    app.run(debug = True)\r\n```\r\n\r\n在第 4 行，编写路径 `/query` 对应的处理函数 `query()`，打印查询参数 `name` 和 `age` 的值。在浏览器中输入 `URL：http://localhost:5000/query?name=zhangsan&age=13` ，查询字符串为 `name=zhangsan&age=13`，包含有两个查询参数 `name` 和 `age`，`Flask` 程序在终端输出如下：\r\n\r\n```python\r\nname = zhangsan\r\nage = 13\r\n```\r\n\r\n4. 解析表单参数\r\n\r\n`request.form` 保存了表单参数，下面编写一个例子 `request-form.py` 解析表单参数：\r\n\r\n```python\r\nfrom flask import Flask, request\r\napp = Flask(__name__)\r\n\r\n@app.route(\'/\')\r\ndef root():\r\n    file = open(\'form.html\', encoding = \'utf-8\')\r\n    return file.read()\r\n\r\n@app.route(\'/addUser\', methods = [\'POST\'])\r\ndef check_login():\r\n    name = request.form[\'name\']\r\n    age = request.form[\'age\']\r\n    print(\'name = %s\' % name)\r\n    print(\'age = %s\' % age)\r\n    return \'addUser OK\'\r\n\r\nif __name__ == \'__main__\':\r\n    app.run(debug = True)\r\n```\r\n\r\n在第 4 行，编写路径 `/` 的处理函数 `root()`，它读取文件 `form.html`，将内容返回给浏览器。在第 9 行，编写路径 `/addUser` 的处理函数 `addUser()`，打印 `request.form` 中的参数 `name` 和 `age`。\r\n\r\n路径 `/` 返回 `form.html`，内容如下：\r\n\r\nform.html 中包含一个表单，action 为 /addUser，method 为 POST，表单中包含有两个字段 name 和 age。访问 localhost:5000 时，浏览器显示如下：', 6, '2023-11-28', 0, 0);
INSERT INTO `blogs` VALUES (32, 'HMM', '## 简介\r\n\r\n隐马尔科夫模型（Hidden Markov Model，以下简称HMM）是比较经典的机器学习模型了，它在语言识别，自然语言处理，模式识别等领域得到广泛的应用。\r\n\r\n当然，随着目前深度学习的崛起，尤其是RNN，LSTM等神经网络序列模型的火热，HMM的地位有所下降。\r\n\r\n但是作为一个经典的模型，学习HMM的模型和对应算法，对我们解决问题建模的能力提高以及算法思路的拓展还是很好的。\r\n\r\n## 什么样的问题需要HMM模型\r\n\r\n首先我们来看看什么样的问题解决可以用HMM模型。\r\n\r\n使用HMM模型时我们的问题一般有这两个特征：\r\n\r\n* 我们的问题是基于序列的，比如时间序列，或者状态序列。\r\n* 我们的问题中有两类数据，一类序列数据是可以观测到的，即观测序列；而另一类数据是不能观察到的，即隐藏状态序列，简称状态序列。\r\n\r\n有了这两个特征，那么这个问题一般可以用HMM模型来尝试解决。这样的问题在实际生活中是很多的。比如：我现在在打字写博客，我在键盘上敲出来的一系列字符就是观测序列，而我实际想写的一段话就是**隐藏序列**，输入法的任务就是从敲入的一系列字符尽可能的猜测我要写的一段话，并把最可能的词语放在最前面让我选择，这就可以看做一个HMM模型了。再举一个，我在和你说话，我发出的一串连续的声音就是**观测序列**，而我实际要表达的一段话就是**状态序列**，你大脑的任务，就是从这一串连续的声音中判断出我最可能要表达的话的内容。\r\n\r\n从这些例子中，我们可以发现，HMM模型可以无处不在。但是上面的描述还不精确，下面我们用精确的数学符号来表述我们的HMM模型。\r\n\r\n## HMM模型的定义\r\n\r\n对于HMM模型，首先我们假设Q是所有可能的隐藏状态的集合，V是所有可能的观测状态的集合，即：\r\n\r\n$$\r\nQ=\\left\\{ q_1,q_2,\\cdots q_N \\right\\} ,V=\\left\\{ v_1,v_2,\\cdots v_M \\right\\} \r\n$$\r\n\r\n其中，$N$是可能的隐藏状态数，$M$是所有的可能的观察状态数。\r\n\r\n对于一个长度为$T$的序列,$I$对应的状态序列,$O$是对应的观察序列，即：\r\n\r\n$$\r\nI=\\left\\{ i_1,i_2\\cdots ,i_T \\right\\} ,O=\\left\\{ o_1,o_2,\\cdots ,o_T \\right\\} \r\n$$\r\n\r\n其中，任意一个隐藏状态$i_t\\in Q$，任意一个观察状态$o_t\\in V$ \r\n\r\nHMM模型做了两个很重要的假设如下：\r\n\r\n* `齐次马尔科夫链假设`。即任意时刻的隐藏状态只依赖于它前一个隐藏状态。当然这样假设有点极端，因为很多时候我们的某一个隐藏状态不仅仅只依赖于前一个隐藏状态，可能是前两个或者是前三个。但是这样假设的好处就是模型简单，便于求解。如果在时刻$t$的隐藏状态是$i_t = q_i$,在时刻$t+1$的隐藏状态是$i_{t+1} = q_j$,则从时刻$t$到时刻$t+1$的表示为：\r\n\r\n    $$\r\n    a_{ij}=P\\left( i_{t+1}=q_j|i_t=q_i \\right) \r\n    $$\r\n\r\n    这样$a_{ij}$可以组成马尔科夫链的状态转移矩阵$A$:\r\n\r\n    $$\r\n    A=\\left[ a_{ij} \\right] _{N\\times N}\r\n    $$\r\n\r\n* `观测独立性假设`。即任意时刻的观察状态只仅仅依赖于当前时刻的隐藏状态，这也是一个为了简化模型的假设。如果在时刻$t$的隐藏状态是$i_t = q_j$,而对应的观察状态为$o_t = v_k$,则该时刻观察状态$v_k$在隐藏状态$q_j$下生成的概率$b_j(k)$满足：\r\n\r\n    $$\r\n    b_j\\left( k \\right) =P\\left( o_t=v_k|i_t=q_j \\right) \r\n    $$\r\n\r\n    这样$b_j(k)$可以组成观测状态生成的概率矩阵\r\n    $B$:\r\n\r\n    $$\r\n    B=\\left[ b_j\\left( k \\right) \\right] _{N\\times M}\r\n    $$\r\n\r\n除此之外，我们需要一组在时刻$t = 1$的隐藏状态概率分布$\\Pi$：\r\n\r\n$$\r\n\\Pi =\\left[ \\pi \\left( i \\right) \\right] _N\r\n$$\r\n\r\n其中$\\pi \\left( i \\right) = P(i_1 = q_i)$\r\n\r\n一个HMM模型，可以由隐藏状态初始概率分布$\\Pi$状态转移概率矩阵$A$和观测状态概率矩阵$B$决定。$\\Pi$，$A$决定状态序列，$B$决定观测序列。因此，HMM模型可以由一个三元组$\\lambda$表示如下：\r\n\r\n$$\r\n\\lambda=(A,B,\\Pi)\r\n$$', 7, '2023-11-28', 0, 0);
INSERT INTO `blogs` VALUES (33, 'CTC', '## 背景介绍\r\n\r\n在序列学习任务中，RNN模型对训练样本一般有这样的依赖条件：输入序列和输出序列之间的映射关系已经事先标注好了。比如，在词性标注任务中，训练样本中每个词（或短语）对应的词性会事先标注好，如下图（DT、NN等都是词性的标注，具体含义请参考链接）。由于输入序列和输出序列是一一对应的，所以RNN模型的训练和预测都是端到端的，即可以根据输出序列和标注样本间的差异来直接定义RNN模型的Loss函数，传统的RNN训练和预测方式可直接适用。\r\n\r\n然而，在语音识别、手写字识别等任务中，由于音频数据和图像数据都是从现实世界中将模拟信号转为数字信号采集得到，这些数据天然就很难进行“分割”，这使得我们很难获取到包含输入序列和输出序列映射关系的大规模训练样本（人工标注成本巨高，且启发式挖掘方法存在很大局限性）。因此，在这种条件下，RNN无法直接进行端到端的训练和预测。\r\n\r\n因此，在语音识别、图像识别等领域中，由于数据天然无法切割，且难以标注出输入和输出的序列映射关系，导致传统的RNN训练方法不能直接适用。那么，如何让RNN模型实现端到端的训练成为了关键问题。\r\n\r\nConnectionist Temporal Classification(CTC)是Alex Graves等人在ICML 2006上提出的一种端到端的RNN训练方法，它可以让RNN直接对序列数据进行学习，而无需事先标注好训练数据中输入序列和输入序列的映射关系，使得RNN模型在语音识别等序列学习任务中取得更好的效果，在语音识别和图像识别等领域CTC算法都有很比较广泛的应用。总的来说，CTC的核心思路主要分为以下几部分：\r\n\r\n1. 它扩展了RNN的输出层，在输出序列和最终标签之间增加了多对一的空间映射，并在此基础上定义了CTC Loss函数\r\n2. 它借鉴了HMM（Hidden Markov Model）的Forward-Backward算法思路，利用动态规划算法有效地计算CTC Loss函数及其导数，从而解决了RNN端到端训练的问题\r\n3. 最后，结合CTC Decoding算法RNN可以有效地对序列数据进行端到端的预测\r\n\r\n## 一个实际的例子–声学模型\r\n\r\n语音识别的核心问题是把一段音频信号序列转化文字序列，传统的语音识别系统主要分为以下几部分，如下图。\r\n\r\n其中，X表示音频信号，O是它的特征表示，一般基于LPC、MFCC等方法提取特征，也可以基于DNN的方式“学到”声学特征的表示。为了简化问题，我们暂且把O理解为是由实数数组组成的序列，它是音频信号的特征表示。Q是O对应的发音字符序列，即建模单元，一般可以是音素、音节、字、词等。W是音频信号X对应的文字序列，即我们最终的识别结果。\r\n\r\n如图所示，核心问题是通过解码器找到令P(W|X)最大化的的W，通过贝叶斯公式可将其分解为P(O|Q)、P(Q|W)、P(W)，分别对应声学模型、发音模型、语言模型。\r\n\r\n其中，声学模型就是对P(O|Q)进行建模，通过训练可以“学到”音频信号和文字发音间的联系。为了简化问题，我们假定声学模型的建模单元Q选择的是音节，O选择的是MFCC特征（由39维数组组成的序列）。\r\n\r\n如下图，输入序列是一段“我爱你中国”的音频，输出序列是音节序列“wo3 ai4 ni3 zhong1 guo2”，如果训练样本中已经“分割”好音频，并标注好它和音节的对应关系，则RNN模型如下：\r\n\r\n然而，如前面所述，对音频“分割”并标注映射关系的数据依赖是不切实际的，实际情况是对音频按照时间窗口滑动来提取特征，比如按照每10毫秒音频提取特征得到一个N维数组。如下图所示：\r\n\r\n由于人说话发音是连续的，且中间也会有“停顿”，所以输出序列中存在重复的元素，比如“wo3 wo3”，也存在表示间隔符号“_”。需从输出序列中去除掉重复的元素以及间隔符，才可得到最终的音节序列，比如，“wo3 wo3 ai4 _ ni3 _ zhong1 guo2 _” 归一处理后得到“wo3 ai4 ni3 zhong1 guo2”。因此，输出序列和最终的label之间存在多对一的映射关系，如下图：\r\n\r\n经过以上的映射转换，解决了端到端训练的问题，RNN模型实际上是对映射到最终label的输出序列的空间建模。然而，对每一个z都“穷举所有的o”，这个计算的复杂度太大，会使得训练速度变得非常慢，因此怎么更高效地进行端到端训练成为待解决的关键问题。\r\n\r\n通过以上的实际例子，我们对问题的解决思路有了更加直观的了解，接下来就开始正式介绍CTC的理论原理。', 7, '2023-11-28', 0, 0);
INSERT INTO `blogs` VALUES (34, 'CTC2', '## 问题定义\r\n\r\n以RNN声学模型为例子，建模的目标是通过训练得到一个RNN模型，使其满足：\r\n\r\n本质上是最大似然预估， S是训练数据集，X和Z分别是输入空间（由音频信号向量序列组成的集合）和目标空间（由声学模型建模单元序列组成的集合），L是由输出的字符集（声学建模单元的集合），且x的序列长度小于或等于z的序列长度。\r\n\r\n接下来，在介绍如何计算Loss函数之前，我们需要对RNN输出层做一个简单的扩展。\r\n\r\n## RNN输出层扩展\r\n\r\n如下图，为了便于读者理解，简化了RNN的结构，只有单向的一层LSTM，把声学建模单元选择为字母{a-z}，并对建模单元字符集做了扩展，且定义了从输出层到最终label序列的多对一映射函数，使得RNN输出层能映射到最终的label序列。\r\n\r\n所以，如果要计算$P\\left( z|x \\right)$，可以累加其对应的全部输出序列(也即映射到最终label的“路径”)的概率即可，如下图。\r\n\r\n## CTC Loss函数定义\r\n\r\n如下图，基于RNN条件独立假设，即可得到CTC Loss函数的定义：\r\n\r\n假定选择单层LSTM为RNN结构，则最终的模型结构如下图：\r\n\r\n## CTC Loss函数计算\r\n\r\n由于直接暴力计算$P\\left( z|x \\right)$的复杂度非常高，作者借鉴HMM的Forward-Backward算法思路，利用动态规划算法求解。\r\n\r\n如下图，为了更形象表示问题的搜索空间，用X轴表示时间序列， Y轴表示输出序列，并把输出序列做标准化处理，输出序列中间和头尾都加上blank，用l表示最终标签，l’表示扩展后的形式，则由2|l| + 1 = 2|l’|，比如：l=apple => l’=_a_p_p_l_e_\r\n\r\n图中并不是所有的路径都是合法路径，所有的合法路径需要遵循一些约束，如下图：\r\n\r\n## 解码\r\n\r\n在上一篇文章中我们详细介绍了CTC问题背景和模型训练的算法和原理，本篇是整体的第二部分，重点介绍CTC模型预测-解码算法。\r\n\r\n一般在分类问题中，训练好模型之后，模型的预测过程非常简单，只需要加载模型文件从前到后执行即可得到分类结果。但在序列学习问题中，模型的预测过程本质是一个空间搜索过程，也称为解码，如何在限定的时间条件下搜索到最优解是一个非常有挑战的问题。下面，我们来详细介绍CTC的解码算法。\r\n\r\n对CTC网络进行Decoding解码本质过程是选取条件概率最大的输出序列，即满足：\r\n\r\n$$\r\narg\\max _yP\\left( y|x \\right) \r\n$$\r\n\r\n解码单元为{a, b, _}，输入序列的长度为2，横轴为时间序列，纵轴为解码单元，栅格中的数字为输出概率\r\n\r\n如上图的例子，按照时间序列展开得到栅格网络，解码的过程相当于空间搜索。我们可以选择暴力的解码策略：穷举搜索，但时间复杂度是指数级的$N^{T}$，显然不可行。我们也可以选择简单的解码策略：在每一步选择概率最大的输出值，这样就可以得到最终解码的输出序列（如上图例子，最终解码的输出序列l=blank）。然而，根据上一篇介绍我们知道，CTC网络的输出序列只对应了搜索空间的一条路径，一个最终标签可对应搜索空间的N条路径，所以概率最大的路径并不等于最终标签的概率最大，即不是最优解（如上图例子，最优解是p(l=b)而不是p(l=blank)）。\r\n\r\n本篇我们介绍两种常见的CTC解码算法：CTC Prefix Search Decoding和CTC Beam Search Decoding。简而言之，Prefix Search Decoding是基于前缀概率的搜索算法，它能确保找到最优解，但最坏情况下耗时可能会随着序列长度呈指数增长；CTC Beam Search Decoding是一种Beam Search算法，它能在限定时间下找到近似解，但不保证一定能找到最优解。', 7, '2023-11-28', 0, 0);
INSERT INTO `blogs` VALUES (35, 'CTC3', '1. CTC Prefix Search Decoding\r\n\r\n    CTC Prefix Search Decoding本质是贪心算法，每一次搜索都会选取“前缀概率”最大的节点扩展，直到找到最大概率的目标label，它的核心是利用动态规划算法计算“前缀概率”。下面先通过一个简单的例子来介绍CTC Prefix Search Decoding的大致过程，如下图。\r\n\r\n    最终label对应的字符集={a, b}，从根节点开始搜索扩展，其子节点为a、b和，每个节点上的数字表示其前缀概率，其中a和b为可扩展节点（表示可以往下扩展子节点），为结束节点（表示不可往下扩展子节点），最终搜索过程会在结束节点上停止，并输出最终的解码label与概率值。\r\n\r\n    如上图例子，CTC Prefix Search搜索过程：\r\n\r\n   1. 初始化最佳序列$l^*$为空集,最佳序列的概率$p\\left( l^* \\right)$,把根节点放入到扩展集合中，初始化它的前缀概率为1.0，初始化$p\\left( l^* \\right) = 0$\r\n   2. 从扩展集合中选取前缀概率最大的节点扩展，扩展子节点a和b，计算a和b的前缀概率（上图中第一层节点a和b的前缀概率分别为0.7和0.2），如果前缀概率大于$p\\left( l^* \\right)$则将其加入到扩展集合。同时，计算结束节点的概率（上图中第一层节点的概率为0.1），如果结束节点的概率大于$p\\left( l^* \\right)$则将其对应的label设置为最佳序列$l^*$,同时更新$p\\left( l^* \\right)$。\r\n   3. 继续搜索，重复步骤2，直到扩展集合为空，即搜索结束，输出最终解码的$l^*$和概率$p\\left( l^* \\right)$，上图中最终$l^*=a , p\\left( l^* \\right) = 0.3$\r\n\r\n    从上面的例子中可以看出，CTC Prefix Search的搜索过程非常简单，核心问题是如何计算前缀概率和每个结束节点对应的概率，它们的计算方式跟上一篇介绍前向概率和后向概率的动态规划算法类似，下面来正式介绍它们的定义与计算方式。\r\n\r\n    定义t时刻前缀为$\\rho$ 的概率为$\\gamma (\\rho,t)$:即在t时刻网络输出序列对应的label为$\\rho$的概率。将$\\gamma (\\rho,t)$划分为两种情况：\r\n    * $\\gamma ^{-}(\\rho,t)$定义为t时刻网络输出blank空字符的概率，\r\n    * $\\gamma ^{+}(\\rho,t)$定义为t时刻网络输出非空字符的概率，则$\\gamma (\\rho,t) = \\gamma ^{-}(\\rho,t) + \\gamma ^{+}(\\rho,t)$。更加正式的定义如下：\r\n\r\n    在给定足够时间的条件下CTC Prefix Search Decoding总能搜索到最大概率值，但随着输入序列长度的增加，搜索过程扩展的前缀可能呈指数级增加。所以在实际应用中为了能够在限定时间的条件下找到近似解，需要增加一些启发式的搜索剪枝策略，比如，分而解之的思路：将搜索空间按照空字符blank来划分为更小的子空间，再针对每个子空间进行CTC Prefix Search。\r\n\r\n    另外，在语音识别等实际应用中，解码过程往往还要加上一些条件约束，即满足：$argmax_{l}p(l|x, G)$，其中G可以是语言模型或语法等约束，取决于具体应用的条件设定。$p(l|x, G)=\\frac{p(l|x)p(l|G)p(x)}{p(x|G)p(l)}$，假定$p(x)$、$p(x|G)$和$p(l)$概率同等，则解码的目标是：$argmax_{y}p(l|x)p(l|G)$。所以，实际应用中可以在解码过程加上限定约束条件，比如，在语音识别中$p(l|G)$可以对应为语言模型或发音模型的概率。\r\n\r\n2. CTC Beam Search Decoding\r\n\r\n    CTC Beam Search Decoding算法虽然简单，但在实际中应用广泛，我们有必要深入了解它的具体实现细节。Beam Search的过程非常简单，每一步搜索选取概率最大的W个节点进行扩展，W也称为Beam Width，其核心还是计算每一步扩展节点的概率。我们先从一个简单的例子来看下搜索的穷举过程，T=3，字符集为{a, b}，其时间栅格表如下图：\r\n\r\n    横轴表示时间，纵轴表示每一步输出层的概率，T=3，字符集为{a, b}\r\n\r\n    如果对它的搜索空间进行穷举搜索，则每一步都展开进行搜索，如下图所示：\r\n\r\n    如上所述，穷举搜索每一步都要扩展全部节点，能保证最终找到最优解（上图中例子最优解$l^*=b$，$p(l^*)=0.164$，但搜索复杂度太高，而Beam Search的思路很简单，每一步只选取扩展概率最大的W个节点进行扩展，如下图所示：\r\n\r\n    由此可见，Beam Search实际上是对搜索数进行了剪枝，使得每一步最多扩展W个节点，而不是随着T的增加而呈指数增长，降低了搜索复杂度。\r\n\r\n    下面我们再介绍CTC Beam Search中最核心的一步，计算节点扩展概率：$\\gamma (\\rho,t)$。跟上一节一样，定义t时刻前缀为$\\rho$ 的概率为$\\gamma (\\rho,t)$：即在t时刻网络输出序列对应的label为$\\rho$的概率。另外，定义$\\hat{\\rho}$为$\\rho$ 的前继前缀，比如$\\rho=ab$，则$\\hat{\\rho}=a$；定义$\\rho^{e}$为字符串$\\rho$的结尾字符，比如$\\rho=abc$，则$\\rho^{e}=c$；定义$\\hat{\\rho}^{e}$为字符串$\\hat{\\rho}$的结尾字符，比如$\\hat{\\rho}=ab$，则$\\hat{\\rho}^{e}=b$。将$\\gamma (\\rho,t)$划分为两种情况：\r\n    * $\\gamma ^{-}(\\rho,t)$定义为t时刻网络输出blank空字符的概率。\r\n    * $\\gamma ^{+}(\\rho,t)$定义为t时刻网络输出非空字符的概率，则$\\gamma (\\rho,t) = \\gamma ^{-}(\\rho,t) + \\gamma ^{+}(\\rho,t)$，我们可以递归求解$\\gamma ^{-}(\\rho,t)$和$\\gamma ^{+}(\\rho,t)$，如下：\r\n\r\n    至此，CTC Beam Search的求解过程就基本介绍完了，如上一节所述，在实际应用中往往需要加上一些条件约束，比如语言模型或语法约束等，我们对扩展字符的过程加上约束，修改$\\gamma ^{-}(\\rho,t)$和$\\gamma ^{+}(\\rho,t)$的递归求解如下：\r\n\r\n    其中，$Pr(\\rho ^{e}|\\hat{\\rho})$表示从$\\hat{\\rho}$到$\\rho$的扩展概率\r\n\r\n    综上所述，CTC Beam Search的算法过程如下：', 7, '2023-11-28', 0, 0);
INSERT INTO `blogs` VALUES (36, 'IOU', '## 什么是IoU\r\n\r\n IoU是一种测量在特定数据集中检测相应物体准确度的一个标准。IoU是一个简单的测量标准，只要是在输出中得出一个预测范围(bounding boxex)的任务都可以用IoU来进行测量。为了可以使IoU用于测量任意大小形状的物体检测，我们需要：\r\n\r\n * ground-truth bounding boxes（人为在训练集图像中标出要检测物体的大概范围）\r\n * 我们的算法得出的结果范围。\r\n\r\n也就是说，这个标准用于测量真实和预测之间的相关度，相关度越高，该值越高。如下图所示。绿色标线是人为标记的正确结果（ground-truth），红色标线是算法预测的结果（predicted）。\r\n\r\n## IoU的计算\r\n\r\nIoU是两个区域重叠的部分除以两个区域的集合部分得出的结果，通过设定的阈值，与这个IoU计算结果比较。\r\n\r\n举例如下：绿色框是准确值，红色框是预测值。', 8, '2023-11-28', 0, 0);
INSERT INTO `blogs` VALUES (37, 'margin loss1', '# margin loss\r\n\r\n[原文](https://gombru.github.io/2019/04/03/ranking_loss/)\r\n\r\nranking loss在很多不同的领域，任务和神经网络结构（比如siamese net或者Triplet net）中被广泛地应用。其广泛应用但缺乏对其命名标准化导致了其拥有很多其他别名，比如对比损失Contrastive loss，边缘损失Margin loss，铰链损失hinge loss和我们常见的三元组损失Triplet loss等。\r\n\r\n## ranking loss函数：度量学习\r\n\r\n不像其他损失函数，比如交叉熵损失和均方差损失函数，这些损失的设计目的就是学习如何去直接地预测标签，或者回归出一个值，又或者是在给定输入的情况下预测出一组值，这是在传统的分类任务和回归任务中常用的。ranking loss的目的是去预测输入样本之间的相对距离。这个任务经常也被称之为度量学习(metric learning)。\r\n\r\n在训练集上使用ranking loss函数是非常灵活的，我们只需要一个可以衡量数据点之间的相似度度量就可以使用这个损失函数了。这个度量可以是二值的（相似/不相似）。比如，在一个人脸验证数据集上，我们可以度量某个两张脸是否属于同一个人（相似）或者不属于同一个人（不相似）。通过使用ranking loss函数，我们可以训练一个CNN网络去对这两张脸是否属于同一个人进行推断。（当然，这个度量也可以是连续的，比如余弦相似度。）\r\n\r\n在使用ranking loss的过程中，我们首先从这两张（或者三张，见下文）输入数据中提取出特征，并且得到其各自的嵌入表达(embedded representation，译者：见[1]中关于数据嵌入的理解)。然后，我们定义一个距离度量函数用以度量这些表达之间的相似度，比如说欧式距离。最终，我们训练这个特征提取器，以对于特定的样本对（sample pair）产生特定的相似度度量。\r\n\r\n尽管我们并不需要关心这些表达的具体值是多少，只需要关心样本之间的距离是否足够接近或者足够远离，但是这种训练方法已经被证明是可以在不同的任务中都产生出足够强大的表征的。\r\n\r\n## ranking loss的表达式\r\n\r\n正如我们一开始所说的，ranking loss有着很多不同的别名，但是他们的表达式却是在众多设置或者场景中都是相同的并且是简单的。我们主要针对以下两种不同的设置，进行两种类型的ranking loss的辨析\r\n\r\n1. 使用一对的训练数据点（即是两个一组）\r\n2. 使用三元组的训练数据点（即是三个数据点一组）\r\n\r\n这两种设置都是在训练数据样本中进行距离度量比较。\r\n\r\n## 成对样本的ranking loss\r\n\r\n![1697867480942](image/margin_loss/1697867480942.png)\r\n\r\nFig 2.1 成对样本ranking loss用以训练人脸认证的例子。在这个设置中，CNN的权重值是共享的。我们称之为Siamese Net。成对样本ranking loss还可以在其他设置或者其他网络中使用。\r\n\r\n在这个设置中，由训练样本中采样到的正样本和负样本组成的两种样本对作为训练输入使用。正样本对$\\left( x_a,x_p \\right)$\r\n由两部分组成，一个锚点样本$x_a$和另一个和之标签相同的样本$x_p$，这个样本$x_p$与锚点样本在我们需要评价的度量指标上应该是相似的（经常体现在标签一样）；负样本对$\\left( x_a,x_n \\right)$由一个锚点样本$x_a$和一个标签不同的样本$x_n$组成，\r\n$x_n$在度量上应该和$x_a$不同。（体现在标签不一致）\r\n\r\n现在，我们的目标就是学习出一个特征表征，这个表征使得正样本对中的度量距离$d$尽可能的小，而在负样本对中，这个距离应该要大于一个人为设定的超参数——阈值$m$。成对样本的ranking loss强制样本的表征在正样本对中拥有趋向于0的度量距离，而在负样本对中，这个距离则至少大于一个阈值。用$r_a,r_p,r_n$分别表示这些样本的特征表征，我们可以有以下的式子：\r\n\r\n$$\r\nL=\\left\\{ \\begin{array}{c}\r\n	d\\left( r_a,r_p \\right)\\,\\,\\text{if}\\left( x_a,x_p \\right)\\\\\r\n	\\max \\left( 0,m-d\\left( r_a,r_n \\right) \\right)\\,\\,\\text{if}\\left( x_a.x_n \\right)\\\\\r\n\\end{array} \\right. \r\n$$\r\n\r\n对于正样本对来说，这个loss随着样本对输入到网络生成的表征之间的距离的减小而减少，增大而增大，直至变成0为止。\r\n\r\n对于负样本来说，这个loss只有在所有负样本对的元素之间的表征的距离都大于阈值$m$的时候才能变成0。当实际负样本对的距离小于阈值的时候，这个loss就是个正值，因此网络的参数能够继续更新优化，以便产生更适合的表征。这个项的loss最大值不会超过\r\n$m$ ,在$d\\left( r_a,r_n \\right)=0$的时候取得。这里设置阈值的目的是，当某个负样本对中的表征足够好，体现在其距离足够远的时候，就没有必要在该负样本对中浪费时间去增大这个距离了，因此进一步的训练将会关注在其他更加难分别的样本对中。\r\n\r\n假设用$r_0,r_1$分别表示样本对两个元素的表征，$y$是一个二值的数值，在输入的是负样本对时为0，正样本对时为1，距离$d$是欧式距离，我们就能有最终的loss函数表达式：\r\n\r\n$$\r\nL\\left( r_0,r_1,y \\right) =y\\left\\| r_0-r_1 \\right\\| +\\left( 1-y \\right) \\max \\left( 0,m-\\left\\| r_0-r_1 \\right\\| \\right) \r\n$$', 8, '2023-11-28', 0, 0);
INSERT INTO `blogs` VALUES (38, 'margin loss2', '## 三元组样本对的ranking loss\r\n\r\n三元组样本对的ranking loss称之为triplet loss。在这个设置中，与二元组不同的是，输入样本对是一个从训练集中采样得到的三元组。这个三元组$(x_a,x_p,x_n)$\r\n由一个锚点样本$x_a$，一个正样本\r\n$x_p$，一个负样本\r\n组成$x_n$。其目标是锚点样本与负样本之间的距离$d(r_a,r_n)$与锚点样本和正样本之间的距离$d(r_a,r_p)$\r\n之差大于一个阈值\r\n，可以表示为：\r\n\r\n$$\r\nL\\left( r_a,r_p,r_n \\right) =\\max \\left( 0,m+d\\left( r_a,r_p \\right) -d\\left( r_a,r_n \\right) \\right) \r\n$$\r\n\r\n\r\n![1697869138284](image/margin_loss/1697869138284.png)\r\n\r\nFig 2.2 Triplet loss的例子，其中的CNN网络的参数是共享的。\r\n\r\n在训练过程中，对于一个可能的三元组，我们的triplet loss可能有三种情况：\r\n\r\n* “简单样本”的三元组(easy triplet)：$d\\left( r_a,r_n \\right) >d\\left( r_a,r_p \\right) +m$在这种情况中，在嵌入空间（译者：指的是以嵌入特征作为表征的欧几里德空间，空间的每个基底都是一个特征维，一般是赋范空间）中，对比起正样本来说，负样本和锚点样本已经有足够的距离了（即是大于\r\n）。此时loss为0，网络参数将不会继续更新。\r\n* 难样本”的三元组(hard triplet)：$d\\left( r_a,r_n \\right) < d\\left( r_a,r_p \\right)$在这种情况中，负样本比起正样本，更接近锚点样本，此时loss为正值（并且比\r\n$m$大，网络可以继续更新。\r\n* 半难样本”的三元组(semi-hard triplet)：$d\\left( r_a,r_p \\right) < d\\left( r_a,r_n \\right)< d\\left( r_a,r_p \\right)+m$在这种情况下，负样本到锚点样本的距离比起正样本来说，虽然是大于后者，但是并没有大于设定的阈值$m$，此时loss仍然为正值，但是小于$m$，此时网络可以继续更新。\r\n\r\n![1697869719815](image/margin_loss/1697869719815.png)\r\n\r\nFig 2.3 三元组可能的情况。\r\n\r\n## 负样本的挑选\r\n\r\n在训练中使用Triplet loss的一个重要选择就是我们需要对负样本进行挑选，称之为负样本选择（negative selection）或者三元组采集（triplet mining）。选择的策略会对训练效率和最终性能结果有着重要的影响。一个明显的策略就是：简单的三元组应该尽可能被避免采样到，因为其loss为0，对优化并没有任何帮助。\r\n\r\n第一个可供选择的策略是离线三元组采集（offline triplet mining），这意味着在训练的一开始或者是在每个世代（epoch）之前，就得对每个三元组进行定义（也即是采样）。\r\n\r\n第二种策略是在线三元组采集（online triplet mining），这种方案意味着在训练中的每个批次（batch）中，都得对三元组进行动态地采样，这种方法经常具有更高的效率和更好的表现。\r\n\r\n然而，最佳的负样本采集方案是高度依赖于任务特性的。但是在本篇文中不会在此深入讨论，因为本文只是对ranking loss的不同别名的综述并且讨论而已。可以参考[2]以对负样本采样进行更深的了解。\r\n\r\n## ranking loss的别名们~名儿可真多啊\r\n\r\nranking loss家族正如以上介绍的，在不同的应用中都有广泛应用，然而其表达式都是大同小异的，虽然他们在不同的工作中名儿并不一致，这可真让人头疼。在这里，我尝试对为什么采用不同的别名，进行解释：\r\n\r\n* ranking loss：这个名字来自于信息检索领域，在这个应用中，我们期望训练一个模型对项目（items）进行特定的排序。比如文件检索中，对某个检索项目的排序等。\r\n* Margin loss：这个名字来自于一个事实——我们介绍的这些loss都使用了边界去比较衡量样本之间的嵌入表征距离，见Fig 2.3\r\n* Contrastive loss：我们介绍的loss都是在计算类别不同的两个（或者多个）数据点的特征嵌入表征。这个名字经常在成对样本的ranking loss中使用。但是我从没有在以三元组为基础的工作中使用这个术语去进行表达。\r\n* Triplet loss：这个是在三元组采样被使用的时候，经常被使用的名字。\r\n* Hinge loss：也被称之为max-margin objective。通常在分类任务中训练SVM的时候使用。他有着和SVM目标相似的表达式和目的：都是一直优化直到到达预定的边界为止。', 8, '2023-11-28', 0, 0);
INSERT INTO `blogs` VALUES (39, 'margin loss3', '## Siamese 网络和 Triplet网络\r\n\r\nSiamese网络（Siamese Net）和Triplet网络（Triplet Net）分别是在成对样本和三元组样本 ranking loss采用的情况下训练模型。\r\n\r\n## Siamese网络\r\n\r\n这个网络由两个相同并且共享参数的CNN网络（两个网络都有相同的参数）组成。这些网络中的每一个都处理着一个图像并且产生对于的特征表达。这两个表达之间会进行比较，并且计算他们之间的距离。然后，一个成对样本的ranking loss将会作为损失函数进行训练模型。\r\n\r\n我们用$f(x)$\r\n表示这个CNN网络，我们有Siamese网络的损失函数如：\r\n\r\n$$\r\nL\\left( x_0,x_1,y \\right) =y\\left\\| f\\left( x_0 \\right) -f\\left( x_1 \\right) \\right\\| +\\left( 1-y \\right) \\max \\left( 0,m-\\left\\| f\\left( x_0 \\right) -f\\left( x_1 \\right) \\right\\| \\right) \r\n$$\r\n\r\n## Triplet网络\r\n\r\n这个基本上和Siamese网络的思想相似，但是损失函数采用了Triplet loss，因此整个网络有三个分支，每个分支都是一个相同的，并且共享参数的CNN网络。同样的，我们能有Triplet网络的损失函数表达为：\r\n\r\n$$\r\nL\\left( x_a,x_p,x_n \\right) =\\max \\left( 0,m+\\left\\| f\\left( x_a \\right) -f\\left( x_p \\right) \\right\\| -\\left\\| f\\left( x_a \\right) -f\\left( x_n \\right) \\right\\| \\right) \r\n$$\r\n\r\n## 在多模态检索中使用ranking loss\r\n\r\n根据我的研究，在涉及到图片和文本的多模态检索任务中，使用了Triplet ranking loss。训练数据由若干有着相应文本标注的图片组成。任务目的是学习出一个特征空间，模型尝试将图片特征和相对应的文本特征都嵌入到这个特征空间中，使得可以将彼此的特征用于在跨模态检索任务中（举个例子，检索任务可以是给定了图片，去检索出相对应的文字描述，那么既然在这个特征空间里面文本和图片的特征都是相近的，体现在距离近上，那么就可以直接将图片特征作为文本特征啦~当然实际情况没有那么简单）。为了实现这个，我们首先从孤立的文本语料库中，学习到文本嵌入信息（word embeddings），可以使用如同Word2Vec或者GloVe之类的算法实现。随后，我们针对性地训练一个CNN网络，用于在与文本信息的同一个特征空间中，嵌入图片特征信息。\r\n\r\n具体来说，实现这个的第一种方法可以是：使用交叉熵损失，训练一个CNN去直接从图片中预测其对应的文本嵌入。结果还不错，但是使用Triplet ranking loss能有更好的结果。\r\n\r\n使用Triplet ranking loss的设置如下：我们使用已经学习好了文本嵌入（比如GloVe模型），我们只是需要学习出图片表达。因此锚点样本$a$是一个图片，正样本$p$是一个图片对应的文本嵌入，负样本$n$是其他无关图片样本的对应的文本嵌入。为了选择文本嵌入的负样本，我们探索了不同的在线负样本采集策略。在多模态检索这个问题上使用三元组样本采集而不是成对样本采集，显得更加合乎情理，因为我们可以不建立显式的类别区分（比如没有label信息）就可以达到目的。在给定了不同的图片后，我们可能会有需要简单三元组样本，但是我们必须留意与难样本的采样，因为采集到的难负样本有可能对于当前的锚点样本，也是成立的（虽然标签的确不同，但是可能很相似。）\r\n\r\n![1697870862776](image/margin_loss/1697870862776.png)\r\n\r\n在该实验设置中，我们只训练了图像特征表征。对于第$i$个图片样本，我们用$f(i)$表示这个CNN网络提取出的图像表征，然后用$t_p,t_n$分别表示正文本样本和负文本样本的GloVe嵌入特征表达，我们有：\r\n\r\n$$\r\nL\\left( i,t_p,t_n \\right) =\\max \\left( 0,m+\\left\\| f\\left( i \\right) -t_p \\right\\| -\\left\\| f\\left( i \\right) -f\\left( t_n \\right) \\right\\| \\right) \r\n$$\r\n\r\n在这种实验设置下，我们对比了triplet ranking loss和交叉熵损失的一些实验的量化结果。我不打算在此对实验细节写过多的笔墨，其实验细节设置和[4,5]一样。基本来说，我们对文本输入进行了一定的查询，输出是对应的图像。当我们在社交网络数据上进行半监督学习的时候，我们对通过文本检索得到的图片进行某种形式的评估。采用了Triplet ranking loss的结果远比采用交叉熵损失的结果好。\r\n\r\n## Reference\r\n\r\n[1]https://blog.csdn.net/LoseInVain/article/details/88373506\r\n\r\n[2]https://omoindrot.github.io/triplet-loss\r\n\r\n[3]https://github.com/adambielski/siamese-triplet\r\n\r\n[4]https://arxiv.org/abs/1901.02004\r\n\r\n[5]https://gombru.github.io/2018/08/01/learning_from_web_data/', 8, '2023-11-28', 0, 0);
INSERT INTO `blogs` VALUES (40, 'Pseudo-Labelling1', '# Pseudo-Labelling\r\n\r\n大数据时代中，在推荐、广告领域样本的获取从来都不是问题，似乎适用于小样本学习的伪标签技术渐渐淡出了人们的视野，但实际上在样本及其珍贵的金融、医疗图像、安全等领域，伪标签学习是一把锋利的匕首，简单而有效。\r\n\r\n## 什么是伪标签技术\r\n\r\n伪标签的定义来自于半监督学习，半监督学习的核心思想是通过借助无标签的数据来提升有监督过程中的模型性能。\r\n\r\n举个简单的半监督学习例子，我想去训练一个通过胸片图像来诊断是否患有乳腺癌的模型，但是专家标注一张胸片图像要收费，于是我掏空自己的钱包让专家帮我标注了10张胸片，可是我这10张图片又要划分训练集测试集，咋训练看着都要过拟合哇，这可咋办？\r\n\r\n聪明的我问了问专家，说不标注的胸片要钱吗？专家一愣，不要钱，随便拿（此处忽略病人隐私的问题，单纯举例子）。于是我掏出1张标注的胸片，换了10张没标注的胸片，在专家还没缓过劲之前先溜了。\r\n\r\n回到家里，我就开始了如图所示的半监督学习过程~\r\n\r\n粗略来讲，伪标签技术就是利用在已标注数据所训练的模型在未标注的数据上进行预测，根据预测结果对样本进行筛选，再次输入模型中进行训练的一个过程。\r\n\r\n但实际上，伪标签技术在具体应用的细节上，远没有说的如此简单，那让我们先看一下伪标签技术的具体做法吧。', 10, '2023-11-28', 0, 0);
INSERT INTO `blogs` VALUES (41, 'Pseudo-Labelling2', '## 伪标签的具体用法\r\n\r\n伪标签技术的使用自由度非常高，在这里我们介绍最常用的也是最有效的三种，对于某些特殊场景，可能有更花哨的方法，这里希望能抛砖引玉，为大家拓宽一下视野。\r\n\r\n1. 入门版\r\n   \r\n   1. 使用标记数据训练有监督模型$M$\r\n   2. 使用有监督模型$M$对无标签数据进行预测，得出预测概率$P$\r\n   3. 通过预测概率$P$筛选高置信度样本\r\n   4. 使用有标记数据以及伪标签数据训练新模型$M^{\\prime}$\r\n\r\n2. 进阶版\r\n   \r\n   1. 使用标记数据训练有监督模型$M$\r\n   2. 使用有监督模型$M$对无标签数据进行预测，得出预测概率$P$\r\n   3. 通过预测概率$P$筛选高置信度样本\r\n   4. 使用有标记数据以及伪标签数据训练新模型$M^{\\prime}$\r\n   5. 将$M$替换为$M^{\\prime}$，重复以上步骤直至模型效果不出现提升\r\n\r\n3. 创新版\r\n   \r\n   1. 使用标记数据训练有监督模型$M$\r\n   2. 使用有监督模型$M$对无标签数据进行预测，得出预测概率$P$\r\n   3. 将模型损失函数改为$Loss=loss(labeled\\_data)+alpha*loss(unlabeled\\_data)$\r\n   4. 使用有标记数据以及伪标签数据训练新模型$M^{\\prime}$\r\n\r\n   以上就是伪标签学习最常用的三种方法。\r\n\r\n   本着知其然、知其所以然的态度，下面介绍一下伪标签为何有效，在知道了为何有效后，才能找到其适合的场景，达到半监督学习的目的。', 10, '2023-11-28', 0, 0);
INSERT INTO `blogs` VALUES (42, 'Pseudo-Labelling3', '## 伪标签为何有效\r\n\r\n在《Pseudo-Label : The Simple and Efficient Semi-Supervised Learning Method for Deep Neural Networks》论文中解释了伪标签学习为何有效，它的有效性可以在两个方面进行考虑，原文如下：\r\n\r\n**Low-Density Separation between Classes**\r\n\r\n```\r\n“The goal of semi-supervised learning is to improve generalization performance using unlabeled data. The cluster assumption states that the decision boundary should lie in low-density regions to improve generalization performance (Chapelle et al., 2005). Recently proposed methods of training neural networks using manifold learning such as Semi-Supervised Embedding and Manifold Tangent Classifier utilize this assumption. Semi-Supervised Embedding (Weston et al., 2008) uses embedding-based regularizer to improve the generalization performance of deep neural networks. Because neighbors of a data sample have similar activations with the sample by embedding based penalty term, it’s more likely that data samples in a high-density region have the same label. Manifold Tangent Classifier (Rifai et al., 2011b) encourages the network output to be insensitive to variations in the directions of low-dimensional manifold. So the same purpose is achieved.”\r\n```\r\n\r\n**Entropy Regularization**\r\n\r\n```\r\n“Entropy Regularization (Grandvalet et al., 2006) is a means to benefit from unlabeled data in the framework of maximum a posteriori estimation. This scheme favors low density separation between classes without any modeling of the density by minimizing the conditional entropy of class probabilities for unlabeled data.”\r\n```\r\n\r\n作者考虑的两个点：\r\n\r\n1. 根据聚类假设（cluster assumption），这些概率较高的点，通常在相同类别的可能性较大，所以其pseudo-label是可信度非常高的。（合理性）\r\n2. 熵正则化是在最大后验估计框架内从未标记数据中获取信息的一种方法，通过最小化未标记数据的类概率的条件熵，促进了类之间的低密度分离，而无需对密度进行任何建模，通过熵正则化与伪标签具有相同的作用效果，都是希望利用未标签数据的分布的重叠程度的信息。（有效性）\r\n\r\n在理论外，伪标签技术给人的第一感觉就是利用置信度高的样本来提升模型的拟合能力。在聚类假设及熵正则化的角度上，这是符合我们的感受的，这也使得使用这项技术变得自然而然。\r\n\r\n值得注意的是：当场景不满足 聚类假设 、熵正则化失效（样本空间覆盖密集）情况下，伪标签技术很有可能失效。在用之前判断适用条件，对症下药，才能将伪标签这把匕首的作用发挥出来。', 10, '2023-11-28', 0, 0);

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`category_id`) USING BTREE,
  INDEX `idx_name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (28, 'CV');
INSERT INTO `categories` VALUES (21, 'web开发');
INSERT INTO `categories` VALUES (22, '人工智能');
INSERT INTO `categories` VALUES (25, '损失函数');
INSERT INTO `categories` VALUES (15, '数据库');
INSERT INTO `categories` VALUES (23, '机器学习');
INSERT INTO `categories` VALUES (24, '深度学习');
INSERT INTO `categories` VALUES (14, '计算机');

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `commenter_id` int NULL DEFAULT NULL,
  `blog_id` int NULL DEFAULT NULL,
  `parent_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`comment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 89 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (27, '好', 5, 23, NULL);
INSERT INTO `comments` VALUES (28, '好', 6, 20, NULL);
INSERT INTO `comments` VALUES (29, '好', 6, 21, NULL);
INSERT INTO `comments` VALUES (30, '好', 6, 22, NULL);
INSERT INTO `comments` VALUES (31, '好', 6, 23, NULL);
INSERT INTO `comments` VALUES (32, '好', 7, 20, NULL);
INSERT INTO `comments` VALUES (33, '好', 7, 20, 28);
INSERT INTO `comments` VALUES (34, '好', 7, 21, NULL);
INSERT INTO `comments` VALUES (35, '好', 7, 22, NULL);
INSERT INTO `comments` VALUES (36, '好', 7, 23, NULL);
INSERT INTO `comments` VALUES (37, '太好了！', 10, 20, NULL);
INSERT INTO `comments` VALUES (38, '这个是上面？', 10, 20, NULL);
INSERT INTO `comments` VALUES (39, '这个写得真不错！', 10, 31, NULL);
INSERT INTO `comments` VALUES (40, '写得有点拉！', 10, 22, 35);
INSERT INTO `comments` VALUES (41, '啊，这是上面呀', 10, 32, NULL);
INSERT INTO `comments` VALUES (42, 'good', 10, 36, NULL);
INSERT INTO `comments` VALUES (43, '写得还行', 10, 40, NULL);
INSERT INTO `comments` VALUES (44, '不错哟！', 8, 20, NULL);
INSERT INTO `comments` VALUES (45, '继续加油', 8, 21, NULL);
INSERT INTO `comments` VALUES (46, '有点拉', 8, 32, NULL);
INSERT INTO `comments` VALUES (47, '不错哟', 8, 30, NULL);
INSERT INTO `comments` VALUES (48, '写错了呀你', 8, 34, NULL);
INSERT INTO `comments` VALUES (49, '真不错', 8, 39, NULL);
INSERT INTO `comments` VALUES (51, '就这样吧', 7, 20, NULL);
INSERT INTO `comments` VALUES (52, '一般般', 7, 31, NULL);
INSERT INTO `comments` VALUES (53, '太酷了', 7, 30, NULL);
INSERT INTO `comments` VALUES (54, '哎哟，不错哟', 7, 21, NULL);
INSERT INTO `comments` VALUES (55, '很不错', 7, 33, NULL);
INSERT INTO `comments` VALUES (56, '只能说，不太行', 6, 20, NULL);
INSERT INTO `comments` VALUES (57, '就这？', 6, 21, NULL);
INSERT INTO `comments` VALUES (59, '我看，就这样吧', 6, 23, NULL);
INSERT INTO `comments` VALUES (60, '还行！', 6, 30, NULL);
INSERT INTO `comments` VALUES (61, '谢谢大家！', 5, 20, NULL);
INSERT INTO `comments` VALUES (62, '懂了懂了，谢谢大家!', 5, 21, NULL);
INSERT INTO `comments` VALUES (64, '还可以以哟', 5, 32, NULL);
INSERT INTO `comments` VALUES (65, '我看，还行呀', 5, 32, 46);
INSERT INTO `comments` VALUES (73, '可以的！', 6, 20, NULL);
INSERT INTO `comments` VALUES (80, '写的可以哟！', 5, 20, NULL);
INSERT INTO `comments` VALUES (81, '写得不错', 5, 41, NULL);
INSERT INTO `comments` VALUES (82, '可以的呀！', 5, 20, NULL);
INSERT INTO `comments` VALUES (89, '好！', 5, 20, NULL);

-- ----------------------------
-- Table structure for tags
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags`  (
  `tag_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`tag_id`) USING BTREE,
  INDEX `idx_name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tags
-- ----------------------------
INSERT INTO `tags` VALUES (22, 'CTC');
INSERT INTO `tags` VALUES (23, 'CTC loss');
INSERT INTO `tags` VALUES (29, 'CV');
INSERT INTO `tags` VALUES (19, 'Flask');
INSERT INTO `tags` VALUES (21, 'HMM');
INSERT INTO `tags` VALUES (28, 'IOU');
INSERT INTO `tags` VALUES (30, 'margin loss');
INSERT INTO `tags` VALUES (14, 'MySQL');
INSERT INTO `tags` VALUES (31, 'Pseudo-Labelling');
INSERT INTO `tags` VALUES (20, 'Python');
INSERT INTO `tags` VALUES (32, '伪标签');

-- ----------------------------
-- Table structure for user_votes
-- ----------------------------
DROP TABLE IF EXISTS `user_votes`;
CREATE TABLE `user_votes`  (
  `vote_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `blog_id` int NULL DEFAULT NULL,
  `vote` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`vote_id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id` ASC, `blog_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_votes
-- ----------------------------
INSERT INTO `user_votes` VALUES (1, 5, 20, -1);
INSERT INTO `user_votes` VALUES (2, 5, 22, 1);
INSERT INTO `user_votes` VALUES (3, 6, 29, 1);
INSERT INTO `user_votes` VALUES (5, 7, 32, 1);
INSERT INTO `user_votes` VALUES (6, 7, 35, 1);
INSERT INTO `user_votes` VALUES (7, 7, 31, -1);
INSERT INTO `user_votes` VALUES (8, 7, 30, 1);
INSERT INTO `user_votes` VALUES (9, 8, 36, 1);
INSERT INTO `user_votes` VALUES (10, 10, 40, 1);
INSERT INTO `user_votes` VALUES (11, 10, 21, 1);
INSERT INTO `user_votes` VALUES (12, 10, 31, 1);
INSERT INTO `user_votes` VALUES (13, 10, 22, 1);
INSERT INTO `user_votes` VALUES (14, 10, 32, -1);
INSERT INTO `user_votes` VALUES (15, 10, 36, 1);
INSERT INTO `user_votes` VALUES (16, 8, 20, 1);
INSERT INTO `user_votes` VALUES (17, 8, 21, 1);
INSERT INTO `user_votes` VALUES (18, 8, 32, -1);
INSERT INTO `user_votes` VALUES (19, 8, 30, 1);
INSERT INTO `user_votes` VALUES (20, 8, 34, -1);
INSERT INTO `user_votes` VALUES (21, 8, 39, 1);
INSERT INTO `user_votes` VALUES (23, 7, 20, -1);
INSERT INTO `user_votes` VALUES (24, 7, 21, 1);
INSERT INTO `user_votes` VALUES (25, 7, 33, 1);
INSERT INTO `user_votes` VALUES (26, 6, 20, -1);
INSERT INTO `user_votes` VALUES (27, 6, 21, -1);
INSERT INTO `user_votes` VALUES (28, 6, 23, -1);
INSERT INTO `user_votes` VALUES (29, 6, 30, 1);
INSERT INTO `user_votes` VALUES (30, 5, 21, 1);
INSERT INTO `user_votes` VALUES (32, 5, 32, 1);
INSERT INTO `user_votes` VALUES (38, 5, 41, 1);
INSERT INTO `user_votes` VALUES (39, 5, 70, 1);
INSERT INTO `user_votes` VALUES (40, 5, 71, 1);
INSERT INTO `user_votes` VALUES (41, 5, 73, 1);
INSERT INTO `user_votes` VALUES (42, 5, 36, 1);
INSERT INTO `user_votes` VALUES (43, 5, 40, 1);
INSERT INTO `user_votes` VALUES (44, 5, 39, 1);
INSERT INTO `user_votes` VALUES (45, 5, 23, 1);
INSERT INTO `user_votes` VALUES (46, 6, 42, 1);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `email` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `is_disabled` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`user_id`) USING BTREE,
  INDEX `idx_username`(`username` ASC) USING BTREE,
  INDEX `idx_email`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (5, 'fmh', 'fmh123', '2099878009@qq.com', 0);
INSERT INTO `users` VALUES (6, 'fmh1', 'fmh1123', '1@qq.com', 0);
INSERT INTO `users` VALUES (7, 'fmh2', 'fmh2123', 'fmh2@qq.com', 0);
INSERT INTO `users` VALUES (8, 'fmh3', 'fmh3123', 'fmh3@qq.com', 0);
INSERT INTO `users` VALUES (10, 'fmh4', 'fmh4123', 'fmh4@qq.com', 0);

-- ----------------------------
-- View structure for announcementadminview
-- ----------------------------
DROP VIEW IF EXISTS `announcementadminview`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `announcementadminview` AS select `announcements`.`announcement_id` AS `announcement_id`,`announcements`.`title` AS `title`,`announcements`.`content` AS `content`,`announcements`.`admin_id` AS `admin_id`,`announcements`.`publish_date` AS `publish_date`,`admins`.`username` AS `admin_username` from (`announcements` left join `admins` on((`announcements`.`admin_id` = `admins`.`admin_id`)));

-- ----------------------------
-- View structure for blogview
-- ----------------------------
DROP VIEW IF EXISTS `blogview`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `blogview` AS select `blogs`.`blog_id` AS `blog_id`,`blogs`.`title` AS `title`,`blogs`.`content` AS `content`,`blogs`.`author_id` AS `author_id`,`blogs`.`publish_date` AS `publish_date`,`categories`.`category_id` AS `category_id`,`tags`.`tag_id` AS `tag_id`,`categories`.`name` AS `category_name`,`tags`.`name` AS `tag_name` from ((((`blogs` left join `blog_categories` on((`blogs`.`blog_id` = `blog_categories`.`blog_id`))) left join `categories` on((`blog_categories`.`category_id` = `categories`.`category_id`))) left join `blog_tags` on((`blogs`.`blog_id` = `blog_tags`.`blog_id`))) left join `tags` on((`blog_tags`.`tag_id` = `tags`.`tag_id`)));

-- ----------------------------
-- View structure for userblogcommentsview
-- ----------------------------
DROP VIEW IF EXISTS `userblogcommentsview`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `userblogcommentsview` AS select `users`.`username` AS `username`,`blogs`.`title` AS `title`,`blogs`.`blog_id` AS `blog_id`,`comments`.`comment_id` AS `comment_id`,`comments`.`content` AS `content` from ((`users` join `comments` on((`users`.`user_id` = `comments`.`commenter_id`))) join `blogs` on((`comments`.`blog_id` = `blogs`.`blog_id`)));

-- ----------------------------
-- Procedure structure for GetAllBlogCount
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetAllBlogCount`;
delimiter ;;
CREATE PROCEDURE `GetAllBlogCount`()
BEGIN
    SELECT COUNT(*) FROM Blogs;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for GetAllCommentCount
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetAllCommentCount`;
delimiter ;;
CREATE PROCEDURE `GetAllCommentCount`()
BEGIN
    SELECT COUNT(*) FROM Comments;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for GetAnnouncementCount
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetAnnouncementCount`;
delimiter ;;
CREATE PROCEDURE `GetAnnouncementCount`()
BEGIN
    SELECT COUNT(*) FROM Announcements;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for GetBlogCountByCategory
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetBlogCountByCategory`;
delimiter ;;
CREATE PROCEDURE `GetBlogCountByCategory`()
BEGIN
    SELECT Categories.name, COUNT(Blog_Categories.blog_id) as blog_count
    FROM Categories
    LEFT JOIN Blog_Categories ON Categories.category_id = Blog_Categories.category_id
    GROUP BY Categories.category_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for GetBlogCountByTag
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetBlogCountByTag`;
delimiter ;;
CREATE PROCEDURE `GetBlogCountByTag`()
BEGIN
    SELECT Tags.name, COUNT(Blog_Tags.blog_id) as blog_count
    FROM Tags
    LEFT JOIN Blog_Tags ON Tags.tag_id = Blog_Tags.tag_id
    GROUP BY Tags.tag_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for GetCategoryCount
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetCategoryCount`;
delimiter ;;
CREATE PROCEDURE `GetCategoryCount`()
BEGIN
    SELECT COUNT(*) FROM Categories;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for GetTagCount
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetTagCount`;
delimiter ;;
CREATE PROCEDURE `GetTagCount`()
BEGIN
    SELECT COUNT(*) FROM Tags;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for GetUserBlogCount
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetUserBlogCount`;
delimiter ;;
CREATE PROCEDURE `GetUserBlogCount`(IN user_id INT)
BEGIN
    SELECT COUNT(*) FROM Blogs WHERE author_id = user_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for GetUserCommentCount
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetUserCommentCount`;
delimiter ;;
CREATE PROCEDURE `GetUserCommentCount`()
BEGIN
    SELECT Users.username, COUNT(Comments.comment_id) as comment_count
    FROM Users
    LEFT JOIN Comments ON Users.user_id = Comments.commenter_id
    GROUP BY Users.user_id;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for GetUserCount
-- ----------------------------
DROP PROCEDURE IF EXISTS `GetUserCount`;
delimiter ;;
CREATE PROCEDURE `GetUserCount`()
BEGIN
    SELECT COUNT(*) as count FROM Users;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table blog_categories
-- ----------------------------
DROP TRIGGER IF EXISTS `delete_empty_categories`;
delimiter ;;
CREATE TRIGGER `delete_empty_categories` AFTER DELETE ON `blog_categories` FOR EACH ROW BEGIN
    DECLARE category_count INT;
    SELECT COUNT(*) INTO category_count FROM Blog_Categories WHERE category_id = OLD.category_id;
    IF category_count = 0 THEN
        DELETE FROM Categories WHERE category_id = OLD.category_id;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table blog_tags
-- ----------------------------
DROP TRIGGER IF EXISTS `delete_empty_tags`;
delimiter ;;
CREATE TRIGGER `delete_empty_tags` AFTER DELETE ON `blog_tags` FOR EACH ROW BEGIN
    DECLARE tag_count INT;
    SELECT COUNT(*) INTO tag_count FROM Blog_Tags WHERE tag_id = OLD.tag_id;
    IF tag_count = 0 THEN
        DELETE FROM Tags WHERE tag_id = OLD.tag_id;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for Users
-- ----------------------------
CREATE TRIGGER delete_user_blogs
BEFORE DELETE ON Users
FOR EACH ROW
BEGIN
    DELETE FROM Blogs WHERE author_id = OLD.user_id;
END;

DROP TRIGGER IF EXISTS delete_user_blogs;

-- ----------------------------
-- Triggers structure for Users
-- ----------------------------
CREATE TRIGGER delete_user_comments
BEFORE DELETE ON Users
FOR EACH ROW
BEGIN
    DELETE FROM Comments WHERE commenter_id = OLD.user_id;
END;

DROP TRIGGER IF EXISTS delete_user_comments;

-- ----------------------------
-- Triggers structure for Blogs
-- ----------------------------
CREATE TRIGGER delete_blog_categories
BEFORE DELETE ON Blogs
FOR EACH ROW
BEGIN
    DELETE FROM Blog_Categories WHERE blog_id = OLD.blog_id;
END;

DROP TRIGGER IF EXISTS delete_blog_categories;

-- ----------------------------
-- Triggers structure for Blogs
-- ----------------------------
CREATE TRIGGER delete_blog_tags
BEFORE DELETE ON Blogs
FOR EACH ROW
BEGIN
    DELETE FROM Blog_Tags WHERE blog_id = OLD.blog_id;
END;

DROP TRIGGER IF EXISTS delete_blog_tags;


-- ----------------------------
-- Triggers structure for Blogs
-- ----------------------------
CREATE TRIGGER delete_blog_votes
BEFORE DELETE ON Blogs
FOR EACH ROW
BEGIN
    DELETE FROM user_votes WHERE blog_id = OLD.blog_id;
END;

DROP TRIGGER IF EXISTS delete_blog_votes;

-- ----------------------------
-- Triggers structure for Users
-- ----------------------------
CREATE TRIGGER delete_user_votes
BEFORE DELETE ON Users
FOR EACH ROW
BEGIN
    DELETE FROM user_votes WHERE user_id = OLD.user_id;
END;

DROP TRIGGER IF EXISTS delete_user_votes;

SET FOREIGN_KEY_CHECKS = 1;

