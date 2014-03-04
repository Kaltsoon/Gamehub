require 'spec_helper'

describe GamesController do
  it "assigns @users" do
    game = FactoryGirl.create(:game)
    get :index
    expect(assigns(:games)).to eq([game])
  end

  it "assigns the requested game" do
    game = FactoryGirl.create(:game)
    get :show, id: game
    expect(assigns(:game)).to eq(game)
  end

  it "renders the index template" do
    get :index
    expect(response).to render_template("index")
  end

  it "renders the show template" do
    game = FactoryGirl.create(:game)
    get :show, id: game
    expect(response).to render_template("show")
  end
end
