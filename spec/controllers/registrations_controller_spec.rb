require "rails_helper"

RSpec.describe RegistrationsController, :type => :controller do

  describe "POST create" do
    before :each do
     @account = Account.new(username: "holtford", email: "theoneandonly@holt.com", password: "mvp")
   end

    it "makes a new account and returns a token" do
      expect {
        post :create, params: {account: {username: @account.username, email: @account.email, password: @account.password}}
      }.to change(Account, :count).by(1)
      expect(response.body).to include("jwt")
    end

    it "has a 401 status code if the account is invalid" do
      post :create, params: {account: {username: @account.username, password: @account.password}}
      expect(response.status).to eq(401)
    end
  end

end
