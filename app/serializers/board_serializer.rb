class BoardSerializer < ActiveModel::Serializer
  attributes :id, :title

  has_many :teams
  has_many :accounts
end
