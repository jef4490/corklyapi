require "rails_helper"

RSpec.describe BoardsController, :type => :controller do

  describe "GET show" do
    before :each do
     @board = Board.create!(title: "A new board")
     @account = Account.create!(username: "alexander", password: "spacelordemperor", email: "darth_zoso@gmail.com")
   end

    it "has a 401 status code if user is not authorized" do
      payload={account_id: @account.id}
      token = Auth.issue(payload)
      headers = { 'token' => token }
      request.headers.merge! headers
      get :show, params: {id: @board.id}
      expect(response.status).to eq(401)
    end

    it "has a 200 status code if the user is authorized" do
      @account.boards << @board
      payload={account_id: @account.id}
      token = Auth.issue(payload)
      headers = { 'token' => token }
      request.headers.merge! headers
      get :show, params: {id: @board.id}
      expect(response.status).to eq(200)
    end

    it "renders the board as json" do
      @account.boards << @board
      payload={account_id: @account.id}
      token = Auth.issue(payload)
      headers = { 'token' => token }
      request.headers.merge! headers
      get :show, params: {id: @board.id}
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq(@board.id)
      expect(json["title"]).to include(@board.title)
    end



  end

end
