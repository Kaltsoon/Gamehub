class CreateGenreGames < ActiveRecord::Migration
  def change
    create_table :genre_games do |t|
      t.integer :game_id
      t.integer :genre_id

      t.timestamps
    end
  end
end
