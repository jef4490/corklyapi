class ElementSerializer < ActiveModel::Serializer
  attributes :id, :x, :y, :height, :width, :content, :bgcolor, :EID, :zIndex

  belongs_to :board
end
