class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :game
      t.string :status

      t.timestamps
    end
  end
end
