import streamlit as st
from streamlit_chat import message as st_message  # 引入streamlit-chat的message组件
from langchain.chains import RetrievalQA
from langchain.prompts.prompt import PromptTemplate
from langchain.vectorstores import FAISS
from langchain.embeddings.huggingface import HuggingFaceEmbeddings
from LLMService import LLMService
from LoadVector import DocumentService
from modelscope import snapshot_download
import pandas as pd
from config import llm_name,llm_revision,vector_store_path,EMBEDDING_model_dir

@st.cache_resource
def init_LLM(llm_name,llm_revision):
    model_dir = snapshot_download(llm_name, revision=llm_revision)
    llm_service = LLMService()
    llm_service.load_model(model_dir)

    return llm_service


@st.cache_data
def init_data(vector_store_path,EMBEDDING_model_dir,docs_paths):
    vector_store_path=vector_store_path
    EMBEDDING_model_dir=EMBEDDING_model_dir
    doc_service = DocumentService(docs_paths,vector_store_path,EMBEDDING_model_dir)
    doc_service.init_source_vector()

    return doc_service


def init_RetrievalQA(LLM,doc_service):

    prompt_template = """基于以下已知信息，简洁和专业的来回答用户的问题。
                                    如果无法从中得到答案，请说 "根据已知信息无法回答该问题" 或 "没有提供足够的相关信息"，不允许在答案中添加编造成分，答案请使用中文。
                                    已知内容:
                                    {context}
                                    问题:
                                    {question}"""
    prompt = PromptTemplate(template=prompt_template, input_variables=["context", "question"])
    knowledge_chain = RetrievalQA.from_llm(llm=LLM,retriever=doc_service.vector_store.as_retriever(search_kwargs={"k": 5}),prompt=prompt)
    knowledge_chain.combine_documents_chain.document_prompt = PromptTemplate(input_variables=["page_content"], template="{page_content}")
    
    return knowledge_chain

# Streamlit应用的主要部分
def main():

    st.sidebar.header("**本地知识库加载**")
    
    # 当accept_multiple_files=True，返回的uploaded_files为一个list
    uploaded_files = st.sidebar.file_uploader("选择文档文件", type=['txt', 'csv'], accept_multiple_files=True,help="支持txt和csv文件格式")

    st.title("本地知识库问答机器人")
    # 使用streamlit-chat来管理对话历史
    if 'dialogues' not in st.session_state:
        st.session_state.dialogues = []

    docs_paths = []  # 存储所有文档路径的列表
    for uploaded_file in uploaded_files:
        if uploaded_file.type == "text/csv":
            # 处理CSV文件
            df = pd.read_csv(uploaded_file,encoding='GBK')
            csv_path = f'{vector_store_path}{uploaded_file.name}'
            df.to_csv(csv_path, index=False)
            docs_paths.append(csv_path)
        elif uploaded_file.type == "text/plain":
            # 处理文本文件，这里简单示例合并文本内容到一个文件
            docs_content = uploaded_file.read()
            if isinstance(docs_content, bytes):
                docs_content = docs_content.decode('utf-8')
            text_path = f'{vector_store_path}{uploaded_file.name}'
            with open(text_path, 'w', encoding='utf-8',errors='ignore') as file:
                file.write(docs_content)
            docs_paths.append(text_path)

    LLM=init_LLM(llm_name,llm_revision)
    if len(uploaded_files) == 0:
        knowledge_chain = LLM
    else:
        doc_service=init_data(vector_store_path,EMBEDDING_model_dir,docs_paths)
        knowledge_chain = init_RetrievalQA(LLM,doc_service)

    # 对话显示和输入逻辑改为使用streamlit-chat
    # 显示对话历史
    for dialogue in st.session_state.dialogues:
        st_message(**dialogue)
    
    
    # 将输入框和提交按钮放在页面的下面
    
    
    user_query = st.chat_input("请输入问题：")
    if user_query:
        # 假设知识链已经被正确初始化
        result_txt = "无法找到答案，请稍后再试。"
        if len(uploaded_files) == 0:
            result_txt = knowledge_chain(user_query)
        else:
            result = knowledge_chain.invoke({"query": user_query})
            result_txt = result['result']
        # 更新对话历史，使用streamlit-chat格式
        st.session_state.dialogues.append({"message": user_query, "is_user": True})
        st.session_state.dialogues.append({"message": result_txt, "is_user": False})
        # 触发页面重新运行来更新对话显示
        st.rerun()

if __name__ == "__main__":
    main()