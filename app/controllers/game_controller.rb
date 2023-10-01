class GameController < ApplicationController
  include GameHelper

  def new
    @game = Game.new
    @game.initialize_chess_game
    if @game.save
      redirect_to game_path @game
    else
      @game.errors.full_messages.each { |msg| p msg }
      redirect_to root_url 
      # impiment flash
    end 
  end

  def show
    @game = Game.find(params[:id])
    @game.load_game
  end

  def update
  end 

  def quit
  end
end
