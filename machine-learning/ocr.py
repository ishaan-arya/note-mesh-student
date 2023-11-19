import fitz  # PyMuPDF

def pdf_to_text(pdf_path, text_path):
    doc = fitz.open(pdf_path)

    with open(text_path, 'w') as text_file:
        for page_num in range(doc.page_count):
            page = doc[page_num]
            text_file.write(page.get_text())
