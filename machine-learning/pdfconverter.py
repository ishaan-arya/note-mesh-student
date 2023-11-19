from fpdf import FPDF
import os

def converttopdf (textfilepath):
    wrap_lines_in_place(textfilepath)
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

def wrap_lines_in_place(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    with open(file_path, 'w') as file:
        for line in lines:
            # Remove leading and trailing whitespaces from the line
            line = line.strip()

            # Check if the line exceeds 100 characters
            if len(line) > 100:
                # Break the line into chunks of at most 100 characters
                chunks = [line[i:i + 100] for i in range(0, len(line), 100)]

                # Write each chunk as a new line
                for chunk in chunks:
                    file.write(chunk + '\n')
            else:
                # If the line is within the limit, write it as is
                file.write(line + '\n')
if __name__ == "__main__":
    converttopdf("./output/output.txt")
