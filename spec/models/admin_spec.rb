require 'spec_helper'

describe Admin do
  it "is not saved if user is blank" do
  	admin = Admin.create()
  	expect(admin.valid?).to eq(false)
  	expect(Admin.count).to eq(0)
  end

  it "is not saved if user already exists" do
  	user = FactoryGirl.create(:user)
  	ad1 = Admin.create(user_id: user.id)
  	expect(ad1.valid?).to eq(true)
  	expect(Admin.count).to eq(1)
  	ad2 = Admin.create(user_id: user.id)
  	expect(ad2.valid?).to eq(false)
  	expect(Admin.count).to eq(1)
  end

  it "is saved if attributes set correctly" do
  	user = FactoryGirl.create(:user)
  	admin = Admin.create(user_id: user.id)
  	expect(admin.valid?).to eq(true)
  	expect(Admin.count).to eq(1)
  end
end
