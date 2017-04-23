require "rails_helper"

RSpec.describe Element, :type => :model do

it "expects Element to exist" do
  element = Element.create!(content: "Yes!")
  expect(!!element).to eq(true)
end

it "expects Element to belong to a board" do
  board = Board.create!(title: "Melissa's notes")
  expect(board.elements).to eq([])
  element = Element.create!(board_id: board.id)
  expect(Board.find(board.id).elements.last).to eq(element)
  expect(element.board).to eq(board)
end

it "expects Element to not be an image by default" do
  element = Element.create!(content: "I sure love being an element!")
  expect(element.is_image).to eq(false)
end



end
