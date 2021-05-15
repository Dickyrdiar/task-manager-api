class AddUserIdToProjectMembers < ActiveRecord::Migration[5.2]
  def change
    add_reference :project_members, :project_id, index: true 
  end
end
