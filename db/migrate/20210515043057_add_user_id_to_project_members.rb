class AddUserIdToProjectMembers < ActiveRecord::Migration[5.2]
  def change
    add_reference :project_members, :user, index: true 
  end
end
