class AddGroupIdToInvitations < ActiveRecord::Migration[5.2]
  def change
    add_reference :invitations, :group, index: true
  end
end
