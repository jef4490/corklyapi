class Elements < ActiveRecord::Migration[5.0]
  def change
    create_table :elements do |t|
      t.integer :board_id
      t.integer :elementId
      t.integer :x
      t.integer :y
      t.integer :height
      t.integer :width
      t.text :content
    end
  end
end
