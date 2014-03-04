class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.integer :user_id
      t.boolean :add_game
      t.boolean :remove_game
      t.boolean :edit_game
      t.boolean :add_genre
      t.boolean :remove_genre
      t.boolean :edit_genre
      t.boolean :give_rights

      t.timestamps
    end
  end
end
