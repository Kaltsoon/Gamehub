require 'spec_helper'

describe Game do
	let(:game){ FactoryGirl.create(:game) }

 	it "is not saved if name is blank" do
 		game = Game.create(description: "lorem ipsum dolor sit amet", published: "1-1-1990", name: "")
 		expect(game.valid?).to eq(false)
 		expect(Game.count).to eq(0)
 	end

 	it "is not saved if description is too short" do
 		game = Game.create(description: "lorem", published: "1-1-1990", name: "peli")
 		expect(game.valid?).to eq(false)
 		expect(Game.count).to eq(0)
 	end

 	it "is not saved if published date is blank" do
 		game = Game.create(description: "lorem ipsum dolor sit amet", published: "", name: "peli")
 		expect(game.valid?).to eq(false)
 		expect(Game.count).to eq(0)
 	end

 	it "is saved if attributes are set correctly" do
 		 game = Game.create(description: "lorem ipsum dolor sit amet", published: "1-1-1990", name: "peli")
 		 expect(game.valid?).to eq(true)
 		expect(Game.count).to eq(1)
 	end

 	it "reviews are removed when game is removed" do
 		user = FactoryGirl.create(:user)
 		expect(game.reviews.count).to eq(0)
 		review = FactoryGirl.create(:review, user: user, game: game)
 		expect(game.reviews.count).to eq(1)
 		game.destroy
 		expect(Review.count).to eq(0)
 	end

 	it "has correct average score" do
 		u1 = FactoryGirl.create(:user, username: "pekka")
 		u2 = FactoryGirl.create(:user, username: "simo")
 		r1 = FactoryGirl.create(:review, user: u1, game: game, score: 50)
 		r1 = FactoryGirl.create(:review, user: u2, game: game, score: 100)
 		expect(game.average_score).to eq(75)
 	end

 	it "has correct number of genres" do
 		g1 = FactoryGirl.create(:genre, name: "genreA")
 		g2 = FactoryGirl.create(:genre, name: "genreB")
 		game.genres.push(g1)
 		game.genres.push(g2)
 		expect(game.genres.count).to eq(2)
 	end
end
