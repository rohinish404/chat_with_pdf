class PdfsController < ApplicationController
  def upload
  end

  def create
    uploaded_file = params[:pdf]
    if uploaded_file
      pdf_path = Rails.root.join('public', 'uploads', uploaded_file.original_filename)
      File.open(pdf_path, 'wb') do |file|
        file.write(uploaded_file.read)
      end
      @pdf = Pdf.create(filename: uploaded_file.original_filename)
      redirect_to chat_path(@pdf)
    else
      render :upload
    end
  end

  def chat
    @pdf = Pdf.find(params[:id])
  end

  def process_chat
    @pdf = Pdf.find(params[:id])
    question = params[:question]
    pdf_path = Rails.root.join('public', 'uploads', @pdf.filename)

    escaped_python_path = Rails.root.join('lib', 'python', 'process_chat.py').to_s.shellescape
    escaped_pdf_path = pdf_path.to_s.shellescape
    escaped_question = question.shellescape
    
    response = `python3 #{escaped_python_path} #{escaped_pdf_path} #{escaped_question}`
    
    render json: { response: response }
  end
end
