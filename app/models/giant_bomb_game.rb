class GiantBombGame
	include ActiveModel::Model

	attr_accessor :description, :name, :image

	def initialize(attributes = {})
	    attributes.each do |name, value|
	      send("#{name}=", value)
	    end
	end
end