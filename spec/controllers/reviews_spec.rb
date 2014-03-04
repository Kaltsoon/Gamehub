require 'spec_helper'

describe ReviewsController do
  it "assigns @reviews" do
    user = FactoryGirl.create(:user)
    game = FactoryGirl.create(:game)
    review = FactoryGirl.create(:review, user: user, game: game)
    get :index
    expect(assigns(:reviews)).to eq([review])
  end

  it "renders the index template" do
    get :index
    expect(response).to render_template("index")
  end
end
