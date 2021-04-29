class AddSlugToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :slug, :string, index: true 
  end
end
