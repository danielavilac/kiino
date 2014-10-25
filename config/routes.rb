Rails.application.routes.draw do
  root 'pages#index'
  get "search", to: "pages#search", as: "search"
  get '/api/kiino/:keyword', to: 'api#kiino'
  get '/api/tweets/:keyword', to: 'api#tweets'
  get '/api/posts/:keyword', to: 'api#posts'
  get '/api/music/:keyword', to: 'api#music'
  get '/api/photos/:keyword', to: 'api#photos'
  get '/api/videos/:keyword', to: 'api#videos'
  get '/api/news/:keyword', to: 'api#news'

end
