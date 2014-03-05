require 'spec_helper'

describe "Genres page" do

  before :all do
    self.use_transactional_fixtures = false
  end
  
  before :each do
    user = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:admin, user: user)
    visit signin_path
    fill_in("username", with: "kalle")
    fill_in("password", with: "kalle123")
    click_button("Sign in")
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

  it "should have posibility to add a genre" do
    visit new_genre_path
    fill_in("genre[name]", with: "genre")
    expect(Genre.count).to eq(0)
    click_button("Create Genre")
    expect(Genre.count).to eq(1)
  end

  it "should have posibility to remove a genre" do
    genre = FactoryGirl.create(:genre)
    visit genre_path(genre)
    expect(Genre.count).to eq(1)
    click_link("Remove")
    expect(Genre.count).to eq(0)
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end
end