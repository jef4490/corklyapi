class ElementSerializer < ActiveModel::Serializer
  attributes :id, :x, :y, :height, :width, :content, :EID

  belongs_to :board
end
