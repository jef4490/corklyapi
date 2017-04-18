class Element < ApplicationRecord
  belongs_to :board, optional: true
  has_attached_file :image
end
