class Review < ActiveRecord::Base
	belongs_to :user
	belongs_to :game

	validates :score, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
	validates :content, length: { minimum: 10 }
	validates :user_id, uniqueness: { scope: :game_id }, presence: true
	validates :game_id, presence: true

	scope :latest, Review.all.order("created_at").limit(3)
	scope :lowest_score, Review.all.order("score").limit(3)
	scope :highest_score, Review.all.order("score DESC").limit(3)

	def synopsis
		return content.length<=100 ? content : "#{content[0..100]}..."
	end
end
