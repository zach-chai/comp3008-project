class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.text :name
      t.text :code
      t.text :term
      t.integer :year
      t.boolean :required, default: false
      t.text :day
      t.time :start_time
      t.time :end_time
      t.text :prerequisites
      t.references :professor, index: true
      t.references :faculty, index: true

      t.timestamps null: false
    end
    add_foreign_key :courses, :professors
    add_foreign_key :courses, :faculties
  end
end
