require 'chess'

class Game < ApplicationRecord
	def initialize_chess_game
		@chess_game = Chess::Game.new
	end

	def chess_game
		@chess_game 
	end 

	before_save :serialize_chess_game

	private 

	def serialize_chess_game
		self.game = YAML::dump(@chess_game)
		self.status = @chess_game.status.to_s
	end
end
