class CreateDirectMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :direct_messages do |t|
      t.text :body
      # t.references :user, foreign_key: true
      # t.references :conversation, foreign_key: true

      t.timestamps
    end
  end
end
