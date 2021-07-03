class AddIdInDirectMessages < ActiveRecord::Migration[5.2]
  def change
    add_reference :direct_messages, :conversation, index: true 
    add_reference :direct_messages, :user, index: true
  end
end
