class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups, id: false do |t|
      t.binary :id, limit: 36, primary_key: true, :null => false
      t.string :name
      t.text :desc

      t.timestamps
    end
  end
end
