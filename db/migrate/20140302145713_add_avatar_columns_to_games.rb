class AddAvatarColumnsToGames < ActiveRecord::Migration
  def self.up
    add_attachment :games, :avatar
  end

  def self.down
    remove_attachment :games, :avatar
  end
end
