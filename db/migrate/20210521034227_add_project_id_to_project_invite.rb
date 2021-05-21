class AddProjectIdToProjectInvite < ActiveRecord::Migration[5.2]
  def change
    add_reference :project_invites, :project, index: true
  end
end
