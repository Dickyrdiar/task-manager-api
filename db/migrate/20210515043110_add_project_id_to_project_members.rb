class AddProjectIdToProjectMembers < ActiveRecord::Migration[5.2]
  def change
    add_reference :project_members, :user_id, index: true
  end
end
