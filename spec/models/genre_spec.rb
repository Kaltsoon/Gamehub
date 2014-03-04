require 'spec_helper'

describe Genre do
  	
  	it "is not saved if name is blank" do
  		genre = Genre.create(name: "")
  		expect(genre.valid?).to eq(false)
  		expect(Genre.count).to eq(0)
  	end

  	it "is not saved if name already exists" do
  		g1 = FactoryGirl.create(:genre)
  		expect(Genre.count).to eq(1)
  		g2 = Genre.create(name: "genre")
  		expect(g2.valid?).to eq(false)
  		expect(Genre.count).to eq(1)
  	end

  	it "is saved if attributes are set correctly" do
  		genre = Genre.create(name: "genre")
  		expect(genre.valid?).to eq(true)
  		expect(Genre.count).to eq(1)
  	end

  	it "has correct number of games" do
  		genre = FactoryGirl.create(:genre)
  		game = FactoryGirl.create(:game)
  		expect(genre.games.count).to eq(0)
  		game.genres.push(genre)
  		expect(genre.games.count).to eq(1)
  	end

end
