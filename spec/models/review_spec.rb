require 'spec_helper'

describe Review do
	let(:user){ FactoryGirl.create(:user) }
	let(:game){ FactoryGirl.create(:game) }

  	it "is not saved if score is over 100" do
  		review = Review.create(score: 101, content: "lorem ipsum dolor sit amet", user_id: user.id, game_id: game.id)
  		expect(review.valid?).to eq(false)
  		expect(Review.count).to eq(0)
	end

	it "is not saved if score is under 0" do
  		review = Review.create(score: -1, content: "lorem ipsum dolor sit amet", user_id: user.id, game_id: game.id)
  		expect(review.valid?).to eq(false)
  		expect(Review.count).to eq(0)
	end

	it "is not saved if content is too short" do
  		review = Review.create(score: 50, content: "lorem", user_id: user.id, game_id: game.id)
  		expect(review.valid?).to eq(false)
  		expect(Review.count).to eq(0)
	end

	it "is not saved game is missing" do
  		review = Review.create(score: 50, content: "lorem ipsum dolor sit amet", user_id: user.id)
  		expect(review.valid?).to eq(false)
  		expect(Review.count).to eq(0)
	end

	it "is not saved if user is missing" do
  		review = Review.create(score: 50, content: "lorem ipsum dolor sit amet", game_id: game.id)
  		expect(review.valid?).to eq(false)
  		expect(Review.count).to eq(0)
	end

	it "is saved if attributes are set correctly" do
		review = Review.create(score: 50, content: "lorem ipsum dolor sit amet", user_id: user.id, game_id: game.id)
  		expect(review.valid?).to eq(true)
  		expect(Review.count).to eq(1)
	end

	it "has game and user set correctly" do
		review = FactoryGirl.create(:review, user: user, game: game)
		expect(review.user).to eq(user)
		expect(review.game).to eq(game)
	end

	it "has correct vote sum" do
		review = FactoryGirl.create(:review, user: user, game: game)
		v1 = FactoryGirl.create(:vote, user: user, review: review)
		expect(review.votes_sum).to eq(1)
	end

end
