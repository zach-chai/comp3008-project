class CreateRegisteredCourses < ActiveRecord::Migration
  def change
    create_table :registered_courses do |t|
      t.references :user, index: true
      t.references :course, index: true
      t.float :grade

      t.timestamps null: false
    end
    add_foreign_key :registered_courses, :users
    add_foreign_key :registered_courses, :courses
  end
end
