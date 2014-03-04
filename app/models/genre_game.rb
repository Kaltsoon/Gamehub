class GenreGame < ActiveRecord::Base
	belongs_to :genre 
	belongs_to :game

	validates :game_id, uniqueness: { scope: :genre_id }
end
