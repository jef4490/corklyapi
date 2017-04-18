class BoardSerializer < ActiveModel::Serializer
  attributes :id, :title

  has_many :accounts, through: :teams
end
