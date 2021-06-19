class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
     
      t.string :name
      t.text :desc
      t.date :date_begining 

      t.timestamps
    end
  end
end
