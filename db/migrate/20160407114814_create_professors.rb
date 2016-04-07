class CreateProfessors < ActiveRecord::Migration
  def change
    create_table :professors do |t|
      t.text :name

      t.timestamps null: false
    end
  end
end
