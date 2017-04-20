class Team < ApplicationRecord
  belongs_to :account
  belongs_to :board

  validates :account, uniqueness: {scope: :board}
end
