Rails.application.routes.draw do
  root 'static_pages#home'
  get '/opponent-setup', to: 'static_pages#opponent_setup'
  get '/about', to: 'static_pages#about'
  get '/game', to: 'static_pages#game'

end
