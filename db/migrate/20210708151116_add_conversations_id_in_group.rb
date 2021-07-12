class AddConversationsIdInGroup < ActiveRecord::Migration[5.2]
  def change
    add_reference :groups, :conversation, index: true 
  end
end
