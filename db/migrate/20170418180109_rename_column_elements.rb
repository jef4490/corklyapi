class RenameColumnElements < ActiveRecord::Migration[5.0]
  def change
    rename_column :elements, :elementId, :EID
  end
end
