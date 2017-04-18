class ElementSerializer < ActiveModel::Serializer
  attributes :id, :x, :y, :height, :width, :content

  belongs_to :board
end
