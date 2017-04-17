class Element < ApplicationRecord
  belongs_to :board
  has_attached_file :image
end
