class GamesController < ApplicationController
  include GamesHelper

  def new
    @game = Game.new
    if @game.save
      redirect_to game_path @game
    else
      @game.errors.full_messages.each { |msg| p msg }
      redirect_to root_url 
      # impiment flash
    end 
  end

  def index
    @games = Game.paginate(per_page: 10, page: params[:page])
  end

  def show
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    begin 
      @game.add_move params[:game][:move]
    rescue Chess::IllegalMoveError => e 
      # Handle illegal move
      p e
    rescue Chess::BadNotationError => e
      # Handle bad notation
      p e
    rescue Exception => e
      # Handle other error
      p e
    end
    @game.save
    if @game.chess_game.over?
      # set flash
      redirect_to root_url # This is temporary
    else
      redirect_to game_path @game 
    end 
  end 

  def quit
  end
end
