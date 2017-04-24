require "rails_helper"

RSpec.describe AccountsController, :type => :controller do

  describe "GET find" do
    before :each do
     @account = Account.create!(username: "holtford", email: "theoneandonly@holt.com", password: "mvp")
   end

   it "has a 200 status code and returns a token if valid paramaters are provided" do
     get :find, params: {email: @account.email}
     expect(response.status).to eq(200)
     expect(response.body).to include(@account.username)
   end

    it "has a 401 status code if the account is invalid" do
      get :find, params: {email: "theholt@holt.com"}
      expect(response.status).to eq(401)
      expect(response.body).to_not include("@account.username")
    end
  end

  describe "GET show" do
    before :each do
       @account = Account.create!(username: "melissa", email: "founder@flakme.io", password: "sideprojects")
       payload={account_id: @account.id}
       token = Auth.issue(payload)
       headers = { 'token' => token }
       request.headers.merge! headers
    end

    it "renders the account information in json if token is valid" do
      get :show
      expect(response.status).to eq(200)
      expect(response.body).to include(@account.username)
    end

  end

end
