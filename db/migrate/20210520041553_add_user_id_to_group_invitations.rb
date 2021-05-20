class AddUserIdToGroupInvitations < ActiveRecord::Migration[5.2]
  def change
    add_reference :group_invitations, :user, index: true
  end
end
