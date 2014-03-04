json.array!(@games) do |game|
  json.extract! game, :id, :name, :published, :description, :reviews, :average_score
  json.url game_url(game, format: :json)
end
