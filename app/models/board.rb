class Board < ApplicationRecord
  has_many :teams
  has_many :accounts, through: :teams
  has_many :elements, :dependent => :destroy
  accepts_nested_attributes_for :elements

  def self.update_board(params)

  end
end
