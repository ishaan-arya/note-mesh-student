from flask import Flask, request, jsonify
from clustering import relevant_clustering
from similarity import calculate_similarity as calc_sim
from pdfconverter import converttopdf
from llm import llama_supernotes
from ocr import pdf_to_text
import os
import shutil
from google.cloud import storage

app = Flask(__name__)

def download_blob(bucket_name, source_blob_name, destination_file_name):
    """Downloads a blob from the bucket."""
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(source_blob_name)
    blob.download_to_filename(destination_file_name)
    print(f"Downloaded {source_blob_name} to {destination_file_name}.")

# Firebase download
def list_files(bucket_name, prefix, local_folder):
    """Lists and downloads all the files in the bucket that are in the specified folder."""
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)

    blobs = bucket.list_blobs(prefix=prefix)
    for blob in blobs:
        if not blob.name.endswith('/'):  # Skip directories
            local_file_path = os.path.join(local_folder, blob.name.replace('/', os.sep))
            local_dir = os.path.dirname(local_file_path)
            if not os.path.exists(local_dir):
                os.makedirs(local_dir)  # Create the directory if it does not exist
            download_blob(bucket_name, blob.name, local_file_path)

# $nameOfClass/$lectureNumber/supernote/filename
# Firebase upload 
def upload_file(bucket_name, destination_path, local_path):
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(destination_path)
    blob.upload_from_filename(local_path)

bucket_name = 'note-mesh.appspot.com'  # Corrected bucket name
local_folder = 'student_notes/'
# Local directory to save the files

def generate_all_txtfiles(path):
    if not os.path.exists('./docs'):
        os.mkdir('./docs')
    if not os.path.exists('./output'):
        os.mkdir('./output')
    list_files(bucket_name, path, "student_notes/notes/ClassName")
    for each in os.listdir('./student_notes/notes/ClassName'):
        filepath = './docs/' + os.path.splitext(each)[0] + '.txt'
        pdf_to_text(each, filepath)


@app.route("/supernotes", methods=['POST'])
def run_llama_supernotes():
    try:
        data = request.json
        generate_all_txtfiles(data.path)
        with open("./output/output.txt", "w") as f:
            output = llama_supernotes("docs")
            f.write(output)
        
        converttopdf("./output/output.txt")
        split_path_list = data.path.split('/')
        db_output_path = split_path_list[0] + '/' + split_path_list[1] + '/supernote/supernote.pdf'
        upload_file(bucket_name, db_output_path, './output/supernote.pdf')
        remove_temp_files()
        return "200"
    except:
        return "400"

@app.route("/clustering", methods=['POST'])
def run_clustering_keywords():
    data = request.json
    generate_all_txtfiles(data.path)
    file_paths  = './docs'
    res = relevant_clustering(file_paths) # returns a dictionary
    remove_temp_files()
    return jsonify(res)

# TODO: change the hardcoded user_file
@app.route("/similarity", methods=['POST'])
def calc_similarity_score():
    try: 
        data = request.json
        generate_all_txtfiles(data.path)
        user_file, super_note = "./docs/The_Prince.txt", "./output/output.txt" # output.txt is the supernote
        percent = calc_sim(user_file, super_note)
        percent *= 100
        return str(round(percent)) + "%", 200
    except:
        error_response = {'error': 'Field not found in JSON'}
        return jsonify(error_response), 400

def remove_temp_files():
    dirs = ['./docs', './output', './student_notes']
    for dir in dirs:
        if os.path.exists(dir):
            shutil.rmtree(dir)
    

if __name__ == '__main__':
    app.run(debug=True)
