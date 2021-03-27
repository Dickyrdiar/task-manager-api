class AddAttachmentImageToMessages < ActiveRecord::Migration[5.2]
  def self.up
    change_table :messages do |t|
      t.string :image
    end
  end

  def self.down
    remove_attachment :messages, :image
  end
end
