class BoardSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :updated_at, :update_me, :currentcolor, :slug, :public, :url

  has_many :accounts, through: :teams
  has_many :elements

  def created_at
    object.created_at.strftime("%-m/%-d/%Y at %I:%M %p")
  end

  def updated_at
    object.updated_at.strftime("%-m/%-d/%Y at %I:%M %p")
  end

  def update_me
    object.updated_at.strftime("%-m/%-d/%Y at %I:%M:%S %p")
  end

end
