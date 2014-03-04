class Genre < ActiveRecord::Base
	has_many :genre_games, dependent: :destroy
	has_many :games, through: :genre_games

	validates :name, uniqueness: { case_sensitive: false }, presence: true, length: { minimum: 3 }

	def to_s
		return name
	end
end
