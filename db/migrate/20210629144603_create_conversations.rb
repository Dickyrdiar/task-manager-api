class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.integer :recipient_id
      t.integer :sender

      t.timestamps
    end
    add_index :conversations, :recipient_id
    add_index :conversations, :sender
    # add_index :conversations, [:recipient_id, :sender_id], unique: true
  end
end
