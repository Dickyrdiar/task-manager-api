class CreateProjectInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :project_invitations, id: false do |t|
      t.binary :id, limit: 36, primary_key: true  
      t.string :email 
      t.integer :sender_id 
      t.string :token

      t.timestamps
    end
  end
end
