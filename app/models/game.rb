require 'chess'


class Game < ApplicationRecord
	validates :status, presence: true
	validate :valid_status
	before_validation :set_status
	after_initialize :create_chess_game
	

	def chess_game
		@chess_game 
	end 

	 def add_move move 
	 	@chess_game.move move # Check move is valid.  This will raise the appropiate exception and halt execution if it is invalid
	 	# move must be valid
	 	self.moves.nil? ? self.moves = "#{move}" : self.moves += ",#{move}"
	 end 

	private 

		def create_chess_game
			@chess_game = Chess::Game.new moves_array
		end

		def set_status
			self.status = @chess_game.status.to_s unless Rails.env.test?
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

		def moves_array
			if self.moves.nil?
				Array.new 
			else
				self.moves.split(',')
			end 
		end
	
end
