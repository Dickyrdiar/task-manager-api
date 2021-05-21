class AddUserIdToProjectInvite < ActiveRecord::Migration[5.2]
  def change
    add_reference :project_invites, :user, index: true
  end
end
