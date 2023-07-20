class CreateCourseOfferings < ActiveRecord::Migration[7.0]
  def change
    create_table :course_offerings do |t|
      t.integer :max_students
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.string :start_time
      t.string :end_time
      t.string :status
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
