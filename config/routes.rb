Rails.application.routes.draw do
  get 'kiinos/index'
  root 'kiinos#index'
end
