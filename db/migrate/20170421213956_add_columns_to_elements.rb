class AddColumnsToElements < ActiveRecord::Migration[5.0]
  def change
    add_column :elements, :image_blob, :string
    add_column :elements, :is_image, :boolean, default: false
  end
end
