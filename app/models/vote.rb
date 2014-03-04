class Vote < ActiveRecord::Base
	belongs_to :review
	belongs_to :user

	validates :value, numericality: { only_integer: true, greater_than_or_equal_to: -1, less_than_or_equal_to: 1, odd: true }
	validates :user_id, uniqueness: { scope: :review_id }
end
