class ElementSerializer < ActiveModel::Serializer
  attributes :id, :x, :y, :height, :width, :content, :bgcolor, :EID, :zIndex, :is_image, :image_blob

  belongs_to :board
end
