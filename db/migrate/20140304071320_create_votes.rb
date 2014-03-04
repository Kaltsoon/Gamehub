class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :review_id
      t.integer :user_id
      t.integer :value

      t.timestamps
    end
  end
end
