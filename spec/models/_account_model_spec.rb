require "rails_helper"

RSpec.describe Account, :type => :model do

it "expects to exist" do
  account = Account.new(username: "jefferson")
  expect(!!account).to eq(true)
end

it "expects to not be valid without a username, password, & email address" do
  account = Account.new
  expect(account).to_not be_valid
  account.username = "peterson"
  expect(account).to_not be_valid
  account.email = "abc@def.com"
  expect(account).to_not be_valid

  jake = Account.new(username: "jake", password: "6453")
  expect(jake).to_not be_valid

  account.password = "doremifaso"
  expect(account).to be_valid
end

it "expects to have many boards" do
  account = Account.create!(username: "davidson", password: "swordfish", email: "dave@therealdave.com")
  board = Board.create!(title: "The ideal board")
  Team.create!(board_id: board.id, account_id: account.id)
  expect(Account.find(account.id).boards).to include(board)
end

end
