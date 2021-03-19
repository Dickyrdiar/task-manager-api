class AddProjectIdToInvitations < ActiveRecord::Migration[5.2]
  def change
    add_reference :invitations, :project, index: true 
  end
end
