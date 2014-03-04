json.array!(@admins) do |admin|
  json.extract! admin, :id, :user_id, :add_game, :remove_game, :edit_game, :add_genre, :remove_genre, :edit_genre, :give_rights
  json.url admin_url(admin, format: :json)
end
