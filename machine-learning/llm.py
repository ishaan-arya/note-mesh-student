from llama_index.llms import Replicate

llama2_7b_chat = "meta/llama-2-7b-chat:8e6975e5ed6174911a6ff3d60540dfd4844201974602551e10e9e87ab143d81e"
llm = Replicate(
    model=llama2_7b_chat,
    temperature=0.01,
    additional_kwargs={"top_p": 1, "max_new_tokens": 3000},
)

# set tokenizer to match LLM
from llama_index import set_global_tokenizer
from transformers import AutoTokenizer

set_global_tokenizer(
    AutoTokenizer.from_pretrained("NousResearch/Llama-2-7b-chat-hf").encode
)

from llama_index.embeddings import HuggingFaceEmbedding
from llama_index import ServiceContext

embed_model = HuggingFaceEmbedding(model_name="BAAI/bge-small-en-v1.5")
service_context = ServiceContext.from_defaults(
    llm=llm, embed_model=embed_model
)

from llama_index import VectorStoreIndex, SimpleDirectoryReader

documents = SimpleDirectoryReader("docs").load_data()
index = VectorStoreIndex.from_documents(
    documents, service_context=service_context
)
query_engine = index.as_query_engine()
query_message = '''Using the data provided, write detailed study notes. 
Keep generating until you are finished summarizing the data.
 Ensure you use all the information provided. 
 Make sure your response looks like a student wrote it during class'''
response = query_engine.query(query_message)
with open('summarize.txt', 'w') as f:
    f.write(response.response)
print(response.response)
