from fpdf import FPDF
import os

def converttopdf (textfilepath):
    with open(textfilepath, 'r') as tmp:
        wpdf = FPDF()
        wpdf.set_font('arial', '', 12)
        wpdf.add_page()
        wpdf.set_xy(10, 5)
        for line in tmp:
            wpdf.cell(50, 5, txt=line, ln=1, align="L")
        

        if(os.path.exists('./output')):
            wpdf.output('./output/supernote.pdf', 'F')
        else:
            os.mkdir('./output')
            wpdf.output('./output/supernote.pdf', 'F')