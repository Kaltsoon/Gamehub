class GiantBombApi

	def self.fetch_game(name)
		url = "http://www.giantbomb.com/api/search/?api_key=#{self.key}&format=json&query=#{ERB::Util.url_encode(name)}&resources=game"
		response = HTTParty.get(url)
		hash = response.parsed_response
		return hash["results"].empty? ? nil : GiantBombGame.new(name: hash["results"].first["name"], description: hash["results"].first["description"], image: hash["results"].first["image"]["thumb_url"]) 
	end

	private

		def self.key
			return "b5e699395852ea78065f0a088cce0a6680e1a08f"
		end
end