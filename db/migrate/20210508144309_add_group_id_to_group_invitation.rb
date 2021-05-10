class AddGroupIdToGroupInvitation < ActiveRecord::Migration[5.2]
  def change
    add_reference :project_invitations, :group, index: true
  end
end
