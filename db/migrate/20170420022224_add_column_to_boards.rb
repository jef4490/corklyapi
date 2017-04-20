class AddColumnToBoards < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :currentcolor, :string
  end
end
