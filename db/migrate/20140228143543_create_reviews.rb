class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :game_id
      t.integer :user_id
      t.integer :score
      t.text :content

      t.timestamps
    end
  end
end
