class AccountSerializer < ActiveModel::Serializer
  attributes :id, :email, :username

  has_many :boards
  has_many :elements, through: :boards
end
