class AddGroupMemberToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :group_member, :string, index: true
  end
end
