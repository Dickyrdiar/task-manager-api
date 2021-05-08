class AddProjectidToProjectInvitation < ActiveRecord::Migration[5.2]
  def change
    add_reference :project_invitations, :project, index: true
  end
end
