class AddUserIdToGroupMembers < ActiveRecord::Migration[5.2]
  def change
    add_reference :group_members, :user, index: true
  end
end
