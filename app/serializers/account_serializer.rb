class AccountSerializer < ActiveModel::Serializer
  attributes :id, :email, :username

  has_many :boards

  def boards
    object.boards.order(:updated_at).reverse_order
  end
end
