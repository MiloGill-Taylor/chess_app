require 'chess'


class Game < ApplicationRecord
	has_many :moves, dependent: :destroy # If a game is deleted, 
										 # all associated moves are removed from db.
										 # Note the plural :moves
	validates :status, presence: true
	validate :valid_status

	def initialize_chess_game
		@chess_game = Chess::Game.new
	end

	def chess_game
		@chess_game 
	end 

	def load_game
		@chess_game = Chess::Game.new moves_array
	end

	def moves_array
			array = []
			moves.each { |move| array << move.move }
			array 
		end 

	private 

		def set_status
			status = @chess_game.status.to_s
		end 

		def valid_status
			valid_states = %w[in_progress white_won black_won 
						  white_won_resign black_won_resign 
						  stalemate insufficient_material 
						  fifty_move_rule threefold_repitition]
			unless valid_states.include? status
				errors.add(:status, 'invalid game state')
			end 
		end 
end
