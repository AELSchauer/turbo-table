class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.integer :course_number
      t.string :name
      t.integer :credits
      t.integer :level
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
