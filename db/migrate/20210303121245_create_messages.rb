class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages, id: false do |t|
      t.binary :id, limit: 36, primary_key: true, :null => false
      t.text :text

      t.timestamps
    end
  end
end
