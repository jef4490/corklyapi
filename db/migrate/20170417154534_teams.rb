class Teams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.integer :board_id
      t.integer :account_id
    end
  end
end
