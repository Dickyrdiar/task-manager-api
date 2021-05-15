class CreateGroupMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :group_members do |t|
      t.string :email
      t.integer :sender_id 
      t.integer :recipient_id 
      t.string :token

      t.timestamps
    end
  end
end
