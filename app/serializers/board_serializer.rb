class BoardSerializer < ActiveModel::Serializer
  attributes :id

  has_many :teams
  has_many :accounts
end
