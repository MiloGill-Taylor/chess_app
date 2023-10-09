require 'stockfish'

class GamesController < ApplicationController
  include GamesHelper

  def new
    if logged_in? 
      black_id = params[:opponent] == 'AI' ? -1 : nil
      @game = Game.new(white_player_id: current_user.id, black_player_id: black_id)
    else
      @game = Game.new(white_player_id: nil, black_player_id: nil)
    end 
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
    p "last move #{@game.chess_game.moves[-1]}"
  end

  def player_move
    @game = Game.find(params[:id])
    move = params[:game][:move]
    move_cycle(@game, move) 
    
  end 

  def ai_move
    engine = Stockfish::Engine.new 
    @game = Game.find(params[:id])
    configure_engine engine 
    pass_position_to_engine(@game, engine)
    if engine_ready? engine 
      move = generate_move engine 
    else 
      p 'oh dear'
      p '#'*200 # should notice that
    end 
    engine.execute "quit"
    p "ai move: #{move}"
    move_cycle(@game, move)
  end 

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    flash[:success] = "Game deleted"
    redirect_back_or_to(root_url, status: :see_other)
  end

  def opponent_setup
  end
end
