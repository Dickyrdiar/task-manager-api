class CreateGroupMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :group_members do |t|
      t.references :user
      t.references :group

      t.timestamps
    end
  end
end
