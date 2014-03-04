require 'spec_helper'

describe "Genres page" do

  before :all do
    self.use_transactional_fixtures = false
  end
  
  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  it "should not display any genres before been created" do
    visit genres_path
    expect(page).to have_content "Genres"
    expect(page).to have_content "0 genres"
  end

  it "should display genres after been created", js:true do
  	g1 = FactoryGirl.create(:genre, name: "genre1")
  	g2 = FactoryGirl.create(:genre, name: "genre2")
  	visit genres_path
  	expect(page).to have_content "2 genres"
  	expect(page).to have_content "genre1"
  	expect(page).to have_content "genre2"
  end

  it "should order genres alphabetically", js:true do
    g1 = FactoryGirl.create(:game, name: "genreA")
    g3 = FactoryGirl.create(:game, name: "genreC")
    g2 = FactoryGirl.create(:game, name: "genreB")
    visit games_path
    find('tbody').find('tr:nth-child(1)').should have_content("genreA")
    find('tbody').find('tr:nth-child(2)').should have_content("genreB")
    find('tbody').find('tr:nth-child(3)').should have_content("genreC")
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end
end