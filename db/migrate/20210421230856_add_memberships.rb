class AddMemberships < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :membership, :string 
    add_column :groups, :membership, :string
  end
end
