class CreateProjectMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :project_members do |t|
      t.references :user
      t.references :project

      t.timestamps
    end
  end
end
