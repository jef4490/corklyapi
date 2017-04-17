class Board < ApplicationRecord
  has_many :teams
  has_many :accounts, through: :teams
  has_many :elements
end
