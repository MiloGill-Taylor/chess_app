Rails.application.routes.draw do
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  resources :games # Creates restful http requests and named paths
end
