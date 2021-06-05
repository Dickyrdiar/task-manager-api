class AddRole < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :string, index: true
    add_column :project_invites, :role, :string, index: true 
    add_column :invitations, :role, :string, index: true
  end
end
