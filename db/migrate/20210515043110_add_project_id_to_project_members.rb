class AddProjectIdToProjectMembers < ActiveRecord::Migration[5.2]
  def change
    add_reference :project_members, :project, index: true
  end
end
