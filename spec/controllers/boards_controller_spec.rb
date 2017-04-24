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

    it "creates a new board && children elements" do
      post :create, params: {board:
        {title: "the best board",
          elements_attributes: [
           {content: "this is a great element"},
           {content: "but not as great as this one"}
         ]
       }}
      expect(response.status).to eq(200)
      expect(Board.all.count).to eq(1)
      expect(Board.last.elements.count).to eq(2)
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

    it "succeeds with a valid authentication token" do
      post :update, params: {id: @board.id, board: {title: "the very best of all boards"}}
      expect(response.status).to eq(200)
    end
  end

  describe "PATCH publish" do
    before :each do
      @account = Account.create!(username: "blacksmith", password: "boston", email: "russell@smith.ma")
      @board = Board.create!(title: "the new standard for all boards")
      @account.boards << @board
      payload={account_id: @account.id}
      token = Auth.issue(payload)
      headers = { 'token' => token }
      request.headers.merge! headers
    end

    it "makes a board publically accessible" do
      patch :publish, params: {id: @board.id}
      expect(response.status).to eq(200)
      expect(Board.find(@board.id).public).to eq(true)
    end

    it "requires the user be a collaborator to succeed" do
      other_account = Account.create!(username: "hacker", password: "person", email: "taking@yourdata.com")
      payload={account_id: other_account.id}
      token = Auth.issue(payload)
      headers = { 'token' => token }
      request.headers.merge! headers
      patch :publish, params: {id: @board.id}
      expect(response.status).to eq(401)
    end
  end

  describe "DELETE destroy" do
    before :each do
      @account = Account.create!(username: "joeyc", password: "guitar", email: "guitar@joeyc.com")
      @board = Board.create!(title: "a place for guitars")
      @account.boards << @board
      payload={account_id: @account.id}
      token = Auth.issue(payload)
      headers = { 'token' => token }
      request.headers.merge! headers
    end

    it "succeeds when the user is collaborator && no other collaborators exist" do
      delete :destroy, params: {id: @board.id}
      expect(response.status).to eq(200)
      expect(Board.all.length).to eq(0)
    end

    it "requires the user to be a collaborator" do
      other_account = Account.create!(username: "publicenemy1337", password: "uwish", email: "illegal@notlegal.io")
      payload={account_id: other_account.id}
      token = Auth.issue(payload)
      headers = { 'token' => token }
      request.headers.merge! headers
      delete :destroy, params: {id: @board.id}
      expect(response.status).to eq(401)
      expect(Board.all.last).to eq(@board)
    end

    it "does not delete board until all collaborators have deleted Board" do
      @jason = Account.create!(username: "therealjason", password: "folkmusic", email: "therealjason@jason.com")
      @jason.boards << @board
      delete :destroy, params: {id: @board.id}
      expect(response.status).to eq(200)
      expect(Board.all.last).to eq(@board)
      expect(Board.all.last.accounts.first).to eq(@jason)
    end
  end

  describe "POST add_owner" do
    before :each do
      @sarah = Account.create!(username: "sarahlite", password: "plants", email: "sarah@lifeisgood.com")
      @board = Board.create!(title: "an amazing place to be!")
      @sarah.boards << @board
      payload={account_id: @sarah.id}
      token = Auth.issue(payload)
      headers = { 'token' => token }
      request.headers.merge! headers
    end

    it "adds a collaborator to the board if user is logged in && not already a collaborator" do
      @khyla = Account.create!(username: "omgbbqdragon", password: "orlndo4lyfe", email: "omgbbq@dragonwtf.com")
      post :add_owner, params: {id: @board.id, account_id: @khyla.id}
      expect(response.status).to eq(200)
      expect(@board.accounts.last).to eq(@khyla)
    end

    it "renders the board if proposed collaborator is already a collaborator" do
      @khyla = Account.create!(username: "omgbbqdragon", password: "orlndo4lyfe", email: "omgbbq@dragonwtf.com")
      post :add_owner, params: {id: @board.id, account_id: @khyla.id}
      expect(response.status).to eq(200)
      expect(@board.accounts.last).to eq(@khyla)
      expect(@board.accounts.length).to eq(2)

      payload={account_id: @khyla.id}
      token = Auth.issue(payload)
      headers = { 'token' => token }
      request.headers.merge! headers
      post :add_owner, params: {id: @board.id, account_id: @sarah.id}
      expect(@board.accounts.length).to eq(2)
    end


  end


end
