class AddGroupIdInConversations < ActiveRecord::Migration[5.2]
  def change
    add_reference :conversations, :group, index: true
  end
end
