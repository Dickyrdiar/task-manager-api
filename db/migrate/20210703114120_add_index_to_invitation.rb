class AddIndexToInvitation < ActiveRecord::Migration[5.2]
  def change
    add_index :invitations, :sender_id 
    add_index :invitations, :recipient_id
    add_index :invitations, [:sender_id, :recipient_id], unique: true
  end
end
