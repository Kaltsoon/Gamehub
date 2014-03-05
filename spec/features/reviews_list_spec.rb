require 'spec_helper'

describe "Reviews page" do

  before :all do
    self.use_transactional_fixtures = false
  end
  
  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  let(:g1){ FactoryGirl.create(:game, name: "game1") }
  let(:g2){ FactoryGirl.create(:game, name: "game2") }
  let(:u1){ FactoryGirl.create(:user, username: "user1") }
  let(:u2){ FactoryGirl.create(:user, username: "user2") }

  it "should not display any reviews before been created" do
    visit reviews_path
    expect(page).to have_content "Reviews"
    expect(page).to have_content "0 reviews"
  end

  it "should display reviews after been created", js:true do
  	r1 = FactoryGirl.create(:review, user: u1, game: g1)
  	r2 = FactoryGirl.create(:review, user: u2, game: g2)
  	visit reviews_path
  	expect(page).to have_content "2 reviews"
  	expect(page).to have_content "user1"
    expect(page).to have_content "game1"
  	expect(page).to have_content "user2"
    expect(page).to have_content "game2"
  end

  it "should order reviews alphabetically by game name", js:true do
    r1 = FactoryGirl.create(:review, user: u1, game: g1)
    r2 = FactoryGirl.create(:review, user: u2, game: g2)
    visit games_path
    find('tbody').find('tr:nth-child(1)').should have_content("game1")
    find('tbody').find('tr:nth-child(2)').should have_content("game2")
  end

  it "should have posibility to add a review" do
    user = FactoryGirl.create(:user)
    visit signin_path
    fill_in("username", with: "kalle")
    fill_in("password", with: "kalle123")
    click_button("Sign in")
    game = FactoryGirl.create(:game)
    visit new_review_path
    expect(Review.count).to eq(0)
    select("peli", from: "review[game_id]")
    fill_in("review[score]", with: "90")
    fill_in("review[content]", with: "lorem ipsum dolor sit amet")
    click_button("Create Review")
    expect(Review.count).to eq(1)
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end
end