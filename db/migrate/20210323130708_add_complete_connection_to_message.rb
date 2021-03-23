class AddCompleteConnectionToMessages < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :user, index: true 
  end
end
