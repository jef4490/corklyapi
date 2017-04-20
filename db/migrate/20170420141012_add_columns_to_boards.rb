class AddColumnsToBoards < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :public, :boolean, default: false
  end
end
