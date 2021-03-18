class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members, id: false do |t|
      t.binary :id, limit: 36, primary_key: true, :null => false

      t.string :email 
      t.string :username

      t.timestamps
    end
  end
end
