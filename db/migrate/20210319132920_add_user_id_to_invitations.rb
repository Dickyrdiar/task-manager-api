class AddUserIdToInvitations < ActiveRecord::Migration[5.2]
  def change
    add_reference :invitations, :user, index: true
  end
end
