class ElementSerializer < ActiveModel::Serializer
  attributes :id, :x, :y, :height, :width, :content, :bgcolor, :EID

  belongs_to :board
end
