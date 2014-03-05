class Game < ActiveRecord::Base
	has_many :reviews, dependent: :destroy
	has_many :genre_games, dependent: :destroy
	has_many :genres, through: :genre_games
	has_many :users, through: :reviews
	
	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	validates :name, presence: true, uniqueness: { case_sensitive: false }
	validates :description, presence: true, length: { minimum: 10 }
	validates :published, presence: true

	scope :latest, order: "published", limit: 3

	def to_s
		return name
	end

	def self.most_popular
		return Game.all.sort_by{|g| -g.reviews.count}.take(3)
	end

	def self.best
		return Game.all.sort_by{|g| -g.average_score}.take(3)
	end

	def average_score
		sum=0
		reviews.each do |r|
			sum = sum + r.score
		end
		return reviews.count==0 ? 0 : (sum/reviews.count).round
	end

	def synopsis
		return description.length<=100 ? description : "#{description[0..100]}..."
	end

end
