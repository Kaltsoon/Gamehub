require 'spec_helper'

describe Vote do
  	let(:user){ FactoryGirl.create(:user) }
  	let(:game){ FactoryGirl.create(:game) }
  	let(:review){ FactoryGirl.create(:review, user: user, game: game) }

    it "is not saved if user has already voted for the review" do
    	v1 = Vote.create(value: 1, user_id: user.id, review_id: review.id)
    	expect(v1.valid?).to eq(true)
    	expect(Vote.count).to eq(1)
    	v2 = Vote.create(value: -1, user_id: user.id, review_id: review.id)
    	expect(v2.valid?).to eq(false)
    	expect(Vote.count).to eq(1)
    end

    it "is not saved if value is not 1 or -1" do
    	v1 = Vote.create(value: 0, user_id: user.id, review_id: review.id)
    	expect(v1.valid?).to eq(false)
    	expect(Vote.count).to eq(0)
    	v2 = Vote.create(value: -2, user_id: user.id, review_id: review.id)
    	expect(v2.valid?).to eq(false)
    	expect(Vote.count).to eq(0)
    	v3 = Vote.create(value: 4, user_id: user.id, review_id: review.id)
    	expect(v3.valid?).to eq(false)
    	expect(Vote.count).to eq(0)
	end

	it "is saved if attributes are set correctly" do
		v1 = Vote.create(value: 1, user_id: user.id, review_id: review.id)
    	expect(v1.valid?).to eq(true)
    	expect(Vote.count).to eq(1)
	end 
end
