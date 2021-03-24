class AddCompletedToMessages < ActiveRecord::Migration[5.2]
  def change
    # add_reference :messages, :project, index: true 
    add_reference :messages, :user, index: true 
  end
end
