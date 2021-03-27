class AddAttachmentImageToGroups < ActiveRecord::Migration[5.2]
  def self.up
    change_table :groups do |t|
      t.string :image
    end
  end

  def self.down
    remove_attachment :groups, :image
  end
end
