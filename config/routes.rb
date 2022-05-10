Rails.application.routes.draw do
  resource :session, only: %i[new create destroy]

  resources :users, only: %i[new create edit update]

  resources :questions do
    resources :answers, except: %i[new show]
  end

  root 'pages#index'
end


# resources :questions, only: %i[index new edit create update destroy show]
# get '/questions', to: 'questions#index'
# get '/questions/new', to: 'questions#new'
# get '/questions/:id/edit', to: 'questions#edit'
# post '/questions', to: 'questions#create'
