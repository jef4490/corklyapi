class BoardSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :updated_at, :currentcolor

  has_many :accounts, through: :teams
  has_many :elements

  def created_at
    object.created_at.strftime("%-m/%-d/%Y at %I:%M %p")
  end

  def updated_at
    object.updated_at.strftime("%-m/%-d/%Y at %I:%M %p")
  end

end
