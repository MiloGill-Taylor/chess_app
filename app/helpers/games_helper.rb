

module GamesHelper
	def piece_img(board, square)
		if board[square] == 'P'
			image_tag 'pieces/wpawn.svg', alt: 'White Pawn', class: 'chess_piece', id: 'P'
		elsif board[square] == 'R'
			image_tag 'pieces/wrook.svg', alt: 'White Rook', class: 'chess_piece', id: 'R'
		elsif board[square] == 'N'
			image_tag 'pieces/wknight.svg', alt: 'White Knight', class: 'chess_piece', id: 'N'
		elsif board[square] == 'B'
			image_tag 'pieces/wbishop.svg', alt: 'White Bishop', class: 'chess_piece', id: 'B'
		elsif board[square] == 'Q'
			image_tag 'pieces/wqueen.svg', alt: 'White Queen', class: 'chess_piece', id: 'Q'
		elsif board[square] == 'K'
			image_tag 'pieces/wking.svg', alt: 'White King', class: 'chess_piece', id: 'K'
		elsif board[square] == 'p'
			image_tag 'pieces/bpawn.svg', alt: 'Black Pawn', class: 'chess_piece', id: 'p'
		elsif board[square] == 'r'
			image_tag 'pieces/brook.svg', alt: 'Black Rook', class: 'chess_piece', id: 'r'
		elsif board[square] == 'n'
			image_tag 'pieces/bknight.svg', alt: 'Black Knight', class: 'chess_piece', id: 'n'
		elsif board[square] == 'b'
			image_tag 'pieces/bbishop.svg', alt: 'Black Bishop', class: 'chess_piece', id: 'b'
		elsif board[square] == 'q'
			image_tag 'pieces/bqueen.svg', alt: 'Black Queen', class: 'chess_piece', id: 'q'
		elsif board[square] == 'k'
			image_tag 'pieces/bking.svg', alt: 'Black King', class: 'chess_piece', id: 'k'
		else
			nil
		end 
	end

	def square_number_to_name square_num 
		if square_num.between?(0, 63)
    		file = ('a'.ord + (square_num % 8)).chr
    		rank = ((square_num / 8) + 1).to_s
    		"#{file}#{rank}"
  		else
    		"Invalid square number"
  		end
	end 

	def get_opponent game 
		# Current implementation is that the logged in player will always be white
		if game.black_player_id == -1
			return 'AI'
		elsif game.black_player_id.nil?
			return 'Guest'
		end 
	end 

	def white_move? game 
		if game.chess_game.active_player == :white 
			'active'
		else
			'inactive'
		end 
	end

	def black_move? game 
		if game.chess_game.active_player == :black 
			'active' 
		else
			'inactive'
		end 
	end

	def ai_turn? game 
		game.black_player_id == -1 && game.chess_game.active_player == :black
	end 

	def users_game? game 
		current_user.id == game.white_player_id
	end 

	def configure_engine engine 
		engine.execute 'setoption name Threads value 1'
		engine.execute 'setoption name Clear Hash'
		engine.execute 'setoption name MultiPV value 1'
		engine.execute 'setoption name Use NNUE value false'
		engine.execute 'setoption name Skill Level value 20'
	end

	def pass_position_to_engine(game, engine)
		fen = game.chess_game.current.to_fen 
		engine.execute "position fen #{fen}"
	end 

	def engine_ready? engine 
		output = engine.execute "isready"

		output == "readyok\n" ? true : false 
	end 

	def generate_move engine 
		output = engine.execute "go depth 5"
		lines = output.split("\n")

		bestmove_line = lines.find { |line| line.include?("bestmove") }

		if bestmove_line
    		bestmove_match = bestmove_line.match(/bestmove\s+(\S+)/)
    		return bestmove_match[1] if bestmove_match
  		end
	end

	def move_cycle(game, move)
		begin 
      		game.add_move move 
      		game.save # Will only run if there were no expections raised
    	rescue Chess::IllegalMoveError => e 
      		# Handle illegal move
      		flash.now[:warning] = 'Illegal Move'
    	rescue Chess::BadNotationError => e
      		# Handle bad notation
      		flash.now[:warning] = 'Incorrect Move Notation'
    	end

    	if @game.chess_game.over?
      		flash[:success] = "Game Over"
      		redirect_to root_url # This is temporary
    	else
    		redirect_to @game, status: :see_other 
    	end 
    end 

end
