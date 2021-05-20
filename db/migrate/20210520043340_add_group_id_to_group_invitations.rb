class AddGroupIdToGroupInvitations < ActiveRecord::Migration[5.2]
  def change
    add_reference :group_invitations, :group, index: true
  end
end
