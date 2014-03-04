FactoryGirl.define do
	factory :user do
		username "kalle"
		password "kalle123"
		password_confirmation "kalle123"
		description "Moi, olen kalle!"
	end

	factory :game do
		name "peli"
		published "1-1-1990"
		description "lorem ipsum dolor sit amet"
	end

	factory :genre do
		name "genre"
	end

	factory :review do
		score 70
		content "lorem ipsum dolor sit amet"
	end

	factory :admin do
		add_game true
		remove_game true
		edit_game true
		add_genre true
		remove_genre true
		edit_genre true
		give_rights true
	end

	factory :vote do
		value 1
	end
end