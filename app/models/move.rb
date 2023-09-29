class Move < ApplicationRecord
  belongs_to :game
  default_scope -> { order(:created_at) }
  validates :game_id, presence: true 
end
