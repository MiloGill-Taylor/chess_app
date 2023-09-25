Rails.application.routes.draw do
  get '/game', to: 'game#new'
  post '/game', to: 'game#show'
  get 'game/load', to: 'game#load'
  get 'game/quit', to: 'game#quit'
  root 'static_pages#home'
  get '/opponent-setup', to: 'static_pages#opponent_setup'
  get '/about', to: 'static_pages#about'

end
