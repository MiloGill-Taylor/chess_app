class CreateMoves < ActiveRecord::Migration[7.0]
  def change
    create_table :moves do |t|
      t.string :move
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
    add_index :moves, [:game_id, :created_at]
  end
end
