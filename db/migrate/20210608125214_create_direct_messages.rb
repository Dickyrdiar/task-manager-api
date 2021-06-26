class CreateDirectMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :direct_messages do |t|
      t.text :text 
      t.string :image

      t.timestamps
    end
  end
end
