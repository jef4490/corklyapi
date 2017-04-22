class AddUrlToBoards < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :url, :string
  end
end
