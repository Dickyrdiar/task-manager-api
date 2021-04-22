class AddProjectMember < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :project_member, :string
    add_column :projects, :project_member, :string
  end
end
