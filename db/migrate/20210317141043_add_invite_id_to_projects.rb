class AddInviteIdToProjects < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :invite, index: true 
  end
end
