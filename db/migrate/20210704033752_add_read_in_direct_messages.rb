class AddReadInDirectMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :direct_messages, :read, :boolean
  end
end
