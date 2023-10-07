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
      @game.save # Will only run if there were no expections raised
    rescue Chess::IllegalMoveError => e 
      # Handle illegal move
      flash[:warning] = 'Illegal Move'
    rescue Chess::BadNotationError => e
      # Handle bad notation
      flash[:warning] = 'Incorrect Move Notation'
    end
    if @game.chess_game.over?
      # set flash
      redirect_to root_url # This is temporary
    else
      #redirect_to game_path @game 
      render 'show', status: :see_other
    end 
  end 

  def destroy
  end
end
