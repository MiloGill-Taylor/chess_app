class AddPlayersToGames < ActiveRecord::Migration[7.0]
  def change
    add_reference :games, :white_player, null: true, foreign_key: {to_table: :users}
    add_reference :games, :black_player, null: true, foreign_key: {to_table: :users}
    add_index     :games, :white_player
    add_index     :games, :black_player
  end
end
