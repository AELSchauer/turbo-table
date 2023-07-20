class CreateCourseOfferingTeachers < ActiveRecord::Migration[7.0]
  def change
    create_table :course_offering_teachers do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :course_offering, null: false, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
