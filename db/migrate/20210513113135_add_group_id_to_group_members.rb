class AddGroupIdToGroupMembers < ActiveRecord::Migration[5.2]
  def change
    add_reference :group_members, :group, index: true 
  end
end
