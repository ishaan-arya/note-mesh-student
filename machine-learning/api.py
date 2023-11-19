from flask import Flask, request, jsonify
from multiprocessing import Process
from clustering import relevant_clustering
from similarity import calculate_similarity as calc_sim
from pdfconverter import converttopdf
from llm import llama_supernotes
from ocr import pdf_to_text
import os
import shutil

app = Flask(__name__)

@app.route("/supernotes", methods=['POST'])
def run_llama_supernotes():
    try:
        if not os.path.exists('./docs'):
            os.mkdir('./docs')
        if not os.path.exists('./output'):
            os.mkdir('./output')
        data = request.json
        list_of_pdfs = ['./test_files/notes1.pdf', './test_files/notes2.pdf', './test_files/The_Prince.pdf']
        for each in list_of_pdfs:
            filepath = './docs/' + os.path.splitext(each)[0] + '.txt'
            pdf_to_text(each, filepath)

        with open("./output/output.txt", "w") as f:
            output = llama_supernotes("docs")
            f.write(output)
        
        converttopdf("./output/output.txt")    
        return "200"
    except:
        return "400"


    # remove_temp_files()
    
@app.route("/clustering", methods=['POST'])
def run_clustering_keywords():
    data = request.json
    file_paths  = './docs'
    res = relevant_clustering(file_paths) # returns a dictionary
    return jsonify(res)

@app.route("/similarity", methods=['POST'])
def calc_similarity_score():
    data = request.json
    user_file, super_note = "./docs/The_Prince.txt", "./docs/notes2.txt"
    percent = calc_sim(user_file, super_note)
    percent *= 100
    return str(round(percent)) + "%"

def remove_temp_files():
    shutil.rmtree('./docs')
    shutil.rmtree('./output')

if __name__ == '__main__':
    app.run(debug=True)
