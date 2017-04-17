class Team < ApplicationRecord
  belongs_to :account
  belongs_to :board
end
