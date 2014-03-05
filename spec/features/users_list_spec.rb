require 'spec_helper'

describe "User page" do

  before :all do
    self.use_transactional_fixtures = false
  end
  
  before :each do
    user = FactoryGirl.create(:user)
    visit signin_path
    fill_in("username", with: "kalle")
    fill_in("password", with: "kalle123")
    click_button("Sign in")
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end
  it "should not display any users before been created" do
    visit users_path
    expect(page).to have_content "Users"
    expect(page).to have_content "1 user"
  end

  it "should display users after been created", js:true do
  	u1 = FactoryGirl.create(:user, username: "user1")
  	u2 = FactoryGirl.create(:user, username: "user2")
  	visit users_path
  	expect(page).to have_content "3 users"
  	expect(page).to have_content "user1"
  	expect(page).to have_content "user2"
  end

  it "should order users alphabetically", js:true do
    u1 = FactoryGirl.create(:game, name: "userA")
    u2 = FactoryGirl.create(:game, name: "userC")
    u3 = FactoryGirl.create(:game, name: "userB")
    u4 = FactoryGirl.create(:game, name: "userD")
    visit games_path
    find('tbody').find('tr:nth-child(1)').should have_content("userA")
    find('tbody').find('tr:nth-child(2)').should have_content("userB")
    find('tbody').find('tr:nth-child(3)').should have_content("userC")
    find('tbody').find('tr:nth-child(4)').should have_content("userD")
  end

  it "can log in" do
    user = FactoryGirl.create(:user)
    visit signin_path
    fill_in("username", with: "kalle")
    fill_in("password", with: "kalle123")
    click_button("Sign in")
  end

  it "should have posibility to create a user" do
    click_link("Sign out")
    visit new_user_path
    count = User.count
    fill_in("user[username]", with: "pekka")
    fill_in("user[password]", with: "pekka123")
    fill_in("user[password_confirmation]", with: "pekka123")
    click_button("Create User")
    expect(User.count).to eq(count+1)
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end
end