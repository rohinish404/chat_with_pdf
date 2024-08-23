Rails.application.routes.draw do
  root 'pdfs#upload'
  post '/upload', to: 'pdfs#create'
  get '/chat/:id', to: 'pdfs#chat', as: 'chat'
  post '/chat/:id', to: 'pdfs#process_chat'
end
