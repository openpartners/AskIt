Rails.application.routes.draw do
  get '/questions', to: 'questions#index' #localhost/questions HTTP GET (verb)
  root 'pages#index'
end