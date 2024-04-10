from langchain.chains import RetrievalQA
from langchain.prompts.prompt import PromptTemplate
from langchain.vectorstores import FAISS
from langchain.embeddings.huggingface import HuggingFaceEmbeddings
from LLMService import LLMService
from LoadVector import DocumentService
from modelscope import snapshot_download



# 加载模型
model_dir = snapshot_download("ZhipuAI/chatglm3-6b", revision = "v1.0.0")
llm_service = LLMService()
llm_service.load_model(model_dir)

# 加载向量
docs_path='./data/1.txt'
vector_store_path='./data/'
EMBEDDING_model_dir='./GanymedeNil/text2vec-large-chinese'
doc_service = DocumentService(docs_path,vector_store_path,EMBEDDING_model_dir)
doc_service.init_source_vector()

prompt_template = """基于以下已知信息，简洁和专业的来回答用户的问题。
                                如果无法从中得到答案，请说 "根据已知信息无法回答该问题" 或 "没有提供足够的相关信息"，不允许在答案中添加编造成分，答案请使用中文。
                                已知内容:
                                {context}
                                问题:
                                {question}"""
prompt = PromptTemplate(template=prompt_template,input_variables=["context", "question"])
knowledge_chain = RetrievalQA.from_llm(llm=llm_service,retriever=doc_service.vector_store.as_retriever(search_kwargs={"k": 5}),prompt=prompt)
knowledge_chain.combine_documents_chain.document_prompt = PromptTemplate(input_variables=["page_content"], template="{page_content}")
# knowledge_chain.return_source_documents = True
### 基于知识库的问答
while True:
    query=input("请输入问题：")
    result = knowledge_chain.invoke({"query": query})
    result_txt=result['result']
    print(result_txt,type(result_txt))