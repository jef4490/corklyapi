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
    board.elements << element
    expect(board.elements.last).to eq(element)
    Element.destroy(element.id)
    expect(board.elements).to eq([])
  end

end
