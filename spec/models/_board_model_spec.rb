require "rails_helper"

RSpec.describe Board, :type => :model do

  it "expects Board to exist" do
      board = Board.create!(title: "I'm a board!")
    expect(!!board).to eq(true)
  end

  it "expects Board to have associated Elements" do
    board = Board.create!(title: "New board here")
    expect(board.elements).to eq([])
    element = Element.create!(board_id: board.id)
    expect(Board.find(board.id).elements.last).to eq(element)
    Element.destroy(element.id)
    expect(Board.find(board.id).elements).to eq([])
  end

  it "expects Board to be private by default" do
    board = Board.create!(title: "I am a simple board")
    expect(board.public).to eq(false)
  end

  it "expects Board to belong to one or more accounts" do
    martha = Account.create!(username: "Martha", password: "1234", email: "martha@gmail.com")
    brent = Account.create!(username: "Brent", password: "1234", email: "brent@gmail.com")
    board = Board.create!(title: "A board with multiple owners")
    expect(Board.find(board.id).accounts.length).to eq(0)

    brent.boards << board
    expect(Board.find(board.id).accounts).to include(brent)

    martha.boards << board
    expect(Board.find(board.id).accounts).to include(martha, brent)
  end

  it "expects Board to have a slug-based url if made public" do
    board = Board.create!(title: "this is a brand new board")
    account = Account.create!(username: "jeff", password: "1234", email: "12@34.com")
    board.slugify(account)
    expect(!!board.url).to eq(true)
    expect(board.url).to include(board.slug, account.username)
  end

end
