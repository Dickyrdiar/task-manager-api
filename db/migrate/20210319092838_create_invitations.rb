class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations, id: false do |t|
      t.binary :id, limit: 36, primary_key: true, :null => false
      t.string :email

      t.timestamps
    end
  end
end
