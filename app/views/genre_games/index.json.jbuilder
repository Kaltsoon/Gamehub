json.array!(@genre_games) do |genre_game|
  json.extract! genre_game, :id, :game_id, :genre_id
  json.url genre_game_url(genre_game, format: :json)
end
