class AddIdToTodolist < ActiveRecord::Migration[5.2]
  def change
    add_reference :todolists, :user, index: true 
    add_reference :todolists, :project, index: true
  end
end
