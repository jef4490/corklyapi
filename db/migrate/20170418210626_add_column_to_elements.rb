class AddColumnToElements < ActiveRecord::Migration[5.0]
  def change
    add_column :elements, :bgcolor, :string
  end
end
