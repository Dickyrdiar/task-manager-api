class AddUseridToProjectInvitation < ActiveRecord::Migration[5.2]
  def change
    add_reference :project_invitations, :user, index: true
  end
end
