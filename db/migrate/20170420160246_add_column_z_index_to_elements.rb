class AddColumnZIndexToElements < ActiveRecord::Migration[5.0]
  def change
    add_column :elements, :zIndex, :integer
  end
end
