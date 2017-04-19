class BoardSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :updated_at

  has_many :accounts, through: :teams
  has_many :elements

end
