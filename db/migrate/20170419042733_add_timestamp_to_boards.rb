class AddTimestampToBoards < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :created_at, :datetime
    add_column :boards, :updated_at, :datetime
  end
end
