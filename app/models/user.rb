class User < ActiveRecord::Base
	has_many :games, through: :reviews
	has_many :reviews, dependent: :destroy

	has_secure_password

	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	validates :username, length: { in: 3..15 }
	validates :description, length: { maximum: 1000 }
	
	scope :latest, User.all.order("created_at").limit(5)

	def favorite_games
		return reviews.sort_by{|r| -r.score}.take(5).map{|r| r.game}
	end

	def to_s
		return username
	end

	def synopsis
		if(description.nil?)
			return ""
		end
		return description.length<=100 ? description : "#{description[0..100]}..."
	end

	def is_current_user?
		return current_user.nil? ? false : (current_user.id==id)
	end

	def has_voted_for_review?(review)
		return (Vote.where(user_id: id, review_id: review.id).count!=0)
	end

	def self.most_active
		return User.all.sort_by{|u| -u.reviews.count}.take(5)
	end
end
