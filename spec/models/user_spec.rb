require 'spec_helper'

describe User do
	let(:user){ FactoryGirl.create(:user) }
	let(:game){ FactoryGirl.create(:game) }
  	it "has the username and description set correctly" do
		user.username.should eq("kalle")
		user.description.should eq("Moi, olen kalle!")
	end

	it "is not saved if password is blank" do
		user = User.create(username: "kalle", password: "", password_confirmation: "")
		expect(user.valid?).to eq(false)
		expect(User.count).to eq(0)
	end

	it "is not saved if password doesn't match confirmation" do
		user = User.create(username: "kalle", password: "kalle123", password_confirmation: "kalle")
		expect(user.valid?).to eq(false)
		expect(User.count).to eq(0)
	end

	it "is not saved if username is too short" do
		user = User.create(username: "k", password: "kalle123", password_confirmation: "kalle123")
		expect(user.valid?).to eq(false)
		expect(User.count).to eq(0)
	end

	it "is saved if attributes set correctly" do
		user = User.create(username: "kalle", password: "kalle123", password_confirmation: "kalle123")
		expect(user.valid?).to eq(true)
		expect(User.count).to eq(1)
	end

	it "has correct number of reviews" do 
		expect(user.reviews.count).to eq(0)
		review = FactoryGirl.create(:review, user: user, game: game)
		expect(user.reviews.count).to eq(1)
	end

	it "reviews are removed when user is removed" do
		review = FactoryGirl.create(:review, user: user, game: game)
		expect(Review.count).to eq(1)
		user.destroy
		expect(Review.count).to eq(0)
	end
end
