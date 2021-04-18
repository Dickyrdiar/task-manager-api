class AddFilenameToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :project_image, :string
  end
end
