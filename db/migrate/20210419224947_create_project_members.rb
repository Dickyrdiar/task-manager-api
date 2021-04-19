class CreateProjectMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :project_members do |t|
      t.belongs_to :user 
      t.belongs_to :project
      t.timestamps
    end
  end
end
