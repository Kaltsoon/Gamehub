json.array!(@genres) do |genre|
  json.extract! genre, :id, :name, :games
  json.url genre_url(genre, format: :json)
end
