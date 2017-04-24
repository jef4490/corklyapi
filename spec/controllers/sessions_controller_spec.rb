require "rails_helper"

RSpec.describe SessionsController, :type => :controller do

  describe "POST create" do
    before :each do
     @account = Account.create!(username: "holtford", email: "theoneandonly@holt.com", password: "mvp")
   end

   it "has a 200 status code and returns a token if valid paramaters are provided" do
     post :create, params: {account: {username: @account.username, password: @account.password}}
     expect(response.status).to eq(200)
     expect(response.body).to include("jwt")
   end

    it "has a 401 status code if the account is invalid" do
      post :create, params: {account: {username: @account.username, password: "pmv"}}
      expect(response.status).to eq(401)
      expect(response.body).to_not include("jwt")
    end

  end

end
