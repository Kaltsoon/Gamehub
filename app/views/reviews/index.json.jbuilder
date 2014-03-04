json.array!(@reviews) do |review|
  json.extract! review, :id, :game_id, :user_id, :score, :content, :user, :game, :created_at
  json.url review_url(review, format: :json)
end
