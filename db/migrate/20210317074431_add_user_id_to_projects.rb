class AddUserIdToProjects < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :user, index: true 
  end
end
