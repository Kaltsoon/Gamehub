require 'spec_helper'

describe "Games page" do

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

  it "should not display any games before been created" do
    visit games_path
    expect(page).to have_content "Games"
    expect(page).to have_content "0 games"
  end

  it "should display games after been created", js:true do
  	g1 = FactoryGirl.create(:game, name: "peli1")
  	g2 = FactoryGirl.create(:game, name: "peli2")
  	visit games_path
  	expect(page).to have_content "2 games"
  	expect(page).to have_content "peli1"
  	expect(page).to have_content "peli2"
  end

  it "should display game information correctly on the list", js:true do
  	g1 = FactoryGirl.create(:game, name: "peli3", published: "1-1-1990")
  	g2 = FactoryGirl.create(:game, name: "peli4", published: "2-2-2000")
  	visit games_path
  	expect(page).to have_content "2 games"
  	expect(page).to have_content "peli3"
  	expect(page).to have_content "January 1, 1990"
  	expect(page).to have_content "peli4"
  	expect(page).to have_content "February 2, 2000"
  end

  it "should order games alphabetically", js:true do
    g1 = FactoryGirl.create(:game, name: "peliA")
    g3 = FactoryGirl.create(:game, name: "peliC")
    g2 = FactoryGirl.create(:game, name: "peliB")
    visit games_path
    find('tbody').find('tr:nth-child(1)').should have_content("peliA")
    find('tbody').find('tr:nth-child(2)').should have_content("peliB")
    find('tbody').find('tr:nth-child(3)').should have_content("peliC")
  end

  it "should have posibility to add a game" do
    visit games_path
    expect(Game.count).to eq(0)
    click_link("New Game")
    fill_in("game[name]", with: "game")
    fill_in("game[description]", with: "lorem ipsum dolor sit amet")
    click_button("Create Game")
    expect(Game.count).to eq(1)
  end

  it "should have posibility to remove a game" do
    game = FactoryGirl.create(:game)
    visit game_path(game)
    expect(Game.count).to eq(1)
    click_link("Remove")
    expect(Game.count).to eq(0)
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end
end