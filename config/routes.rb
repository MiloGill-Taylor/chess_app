Rails.application.routes.draw do
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/setup', to: 'games#opponent_setup'
  resources    :games, except: :update do 
    member do 
      patch '',    to: 'games#player_move'
      get '/ai', to: 'games#ai_move', as: :ai_move
    end 
  end 
  resources    :users
  get '/login',     to: 'sessions#new'
  post '/login',    to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
