from llama_index.llms import Replicate
from llama_index import set_global_tokenizer # set tokenizer to match LLM
from transformers import AutoTokenizer
from llama_index.embeddings import HuggingFaceEmbedding
from llama_index import ServiceContext
from llama_index import VectorStoreIndex, SimpleDirectoryReader

query_message = '''Using the data provided, write detailed study notes. 
    Keep generating until you are finished summarizing the data.
    Ensure you use all the information provided. 
    Make sure your response looks like a student wrote it during class'''
llama2_7b_chat = "meta/llama-2-7b-chat:8e6975e5ed6174911a6ff3d60540dfd4844201974602551e10e9e87ab143d81e"

def llama_supernotes(folderpath):
    llm = Replicate(
        model=llama2_7b_chat,
        temperature=0.01,
        additional_kwargs={"top_p": 1, "max_new_tokens": 3000},
    )

    set_global_tokenizer(
        AutoTokenizer.from_pretrained("NousResearch/Llama-2-7b-chat-hf").encode
    )

    embed_model = HuggingFaceEmbedding(model_name="BAAI/bge-small-en-v1.5")
    service_context = ServiceContext.from_defaults(
        llm=llm, embed_model=embed_model
    )

    documents = SimpleDirectoryReader(folderpath).load_data()
    index = VectorStoreIndex.from_documents(
        documents, service_context=service_context
    )
    query_engine = index.as_query_engine()
    response = query_engine.query(query_message)
    if __name__ == "__main__":
        print(response.response)
    return response.response

if __name__ == "__main__":
    llama_supernotes("docs")

