class AddProjectReferenceToMessages < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :project, index: true
  end
end
