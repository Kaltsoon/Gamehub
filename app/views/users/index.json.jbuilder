json.array!(@users) do |user|
  json.extract! user, :id, :username, :description, :password_digest, :reviews, :created_at
  json.url user_url(user, format: :json)
end
