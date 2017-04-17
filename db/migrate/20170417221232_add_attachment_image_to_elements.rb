class AddAttachmentImageToElements < ActiveRecord::Migration
  def self.up
    change_table :elements do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :elements, :image
  end
end
