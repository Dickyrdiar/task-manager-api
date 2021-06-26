class AddUserIdToDirectMessages < ActiveRecord::Migration[5.2]
  def change
    add_reference :direct_messages, :user, index: true
  end
end
