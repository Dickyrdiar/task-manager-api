class AddUserIdToGroups < ActiveRecord::Migration[5.2]
  def change
    add_reference :groups, :user, index: true 
  end
end
