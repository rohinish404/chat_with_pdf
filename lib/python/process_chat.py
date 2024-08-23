import sys
import groq
import PyPDF2
import os

def extract_text_from_pdf(pdf_path):
    with open(pdf_path, 'rb') as file:
        reader = PyPDF2.PdfReader(file)
        text = ''
        for page in reader.pages:
            text += page.extract_text()
    return text

def chat_with_groq(pdf_text, question):
    client = groq.Client(api_key=os.getenv("GROQ_API_KEY"))
    response = client.chat.completions.create(
        messages=[
            {"role": "system", "content": f"You are an AI assistant that answers questions based on the following PDF content: {pdf_text}"},
            {"role": "user", "content": question}
        ],
        model="mixtral-8x7b-32768",
    )
    return response.choices[0].message.content

if __name__ == "__main__":
    pdf_path = sys.argv[1]
    question = sys.argv[2]
    
    pdf_text = extract_text_from_pdf(pdf_path)
    response = chat_with_groq(pdf_text, question)
    print(response)
