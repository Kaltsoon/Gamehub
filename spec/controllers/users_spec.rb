require 'spec_helper'

describe UsersController do
  it "assigns @users" do
    user = FactoryGirl.create(:user)
    get :index
    expect(assigns(:users)).to eq([user])
  end

  it "assigns the requested user" do
    user = FactoryGirl.create(:user)
    get :show, id: user
    expect(assigns(:user)).to eq(user)
  end

  it "renders the index template" do
    get :index
    expect(response).to render_template("index")
  end

  it "renders the show template" do
    user = FactoryGirl.create(:user)
    get :show, id: user
    expect(response).to render_template("show")
  end
end
