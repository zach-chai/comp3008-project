class CreateFaculties < ActiveRecord::Migration
  def change
    create_table :faculties do |t|
      t.text :name
      t.text :code

      t.timestamps null: false
    end
  end
end
