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

  describe "GET show_public" do
    before :each do
      @public_board = Board.create!(title: "A new board")
      @account = Account.create!(username: "alexander", password: "spacelordemperor", email: "darth_zoso@gmail.com")
      @public_board.slugify(@account)
      @public_board.save
      @private_board = Board.create!(title: "Another new board")
    end

    it "has a 401 status code when the board is private" do
      get :show_public, params: {slug: "not-a-slug"}
      expect(response.status).to eq(401)
    end

    it "will render a public board without authentication if it exists" do
      get :show_public, params: {slug: @public_board.slug}
      expect(response.status).to eq(200)
    end
  end

  describe "POST create" do
    before :each do
      @account = Account.create!(username: "lefty", password: "failure", email: "lefty@lefty.com")
      payload={account_id: @account.id}
      token = Auth.issue(payload)
      headers = { 'token' => token }
      request.headers.merge! headers
    end

    it "has a 401 status code when params are incomplete" do
      post :create, params: {board: {id: 2}}
      expect(response.status).to eq(401)
    end

    it "has a 200 status code when params are provided" do
      post :create, params: {board: {title: "the best board"}}
      expect(response.status).to eq(200)
    end
  end

  describe "PATCH update" do
    before :each do
      @account = Account.create!(username: "lefty", password: "failure", email: "lefty@lefty.com")
      @board = Board.create!(title: "the new standard for all boards")
      @account.boards << @board
      payload={account_id: @account.id}
      token = Auth.issue(payload)
      headers = { 'token' => token }
      request.headers.merge! headers
    end

    it "requires a valid authentication token to succeed" do
      other_account = Account.create!(username: "bad", password: "dude", email: "stealing@yerstuff.com")
      payload={account_id: other_account.id}
      token = Auth.issue(payload)
      headers = { 'token' => token }
      request.headers.merge! headers
      post :update, params: {id: @board.id, board: {title: "the best board"}}
      expect(response.status).to eq(401)
    end

  end


end
