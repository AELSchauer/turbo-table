class CreateCourseOfferingStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :course_offering_students do |t|
      t.references :student, null: false, foreign_key: true
      t.references :course_offering, null: false, foreign_key: true
      t.string :grade

      t.timestamps
    end
  end
end
