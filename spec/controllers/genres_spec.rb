require 'spec_helper'

describe GenresController do
  it "assigns @users" do
    genre = FactoryGirl.create(:genre)
    get :index
    expect(assigns(:genres)).to eq([genre])
  end

  it "assigns the requested game" do
    genre = FactoryGirl.create(:genre)
    get :show, id: genre
    expect(assigns(:genre)).to eq(genre)
  end

  it "renders the index template" do
    get :index
    expect(response).to render_template("index")
  end

  it "renders the show template" do
    genre = FactoryGirl.create(:genre)
    get :show, id: genre
    expect(response).to render_template("show")
  end
end