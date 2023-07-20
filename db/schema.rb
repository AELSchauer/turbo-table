# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_20_200621) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_offering_students", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "course_offering_id", null: false
    t.string "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_offering_id"], name: "index_course_offering_students_on_course_offering_id"
    t.index ["student_id"], name: "index_course_offering_students_on_student_id"
  end

  create_table "course_offering_teachers", force: :cascade do |t|
    t.bigint "teacher_id", null: false
    t.bigint "course_offering_id", null: false
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_offering_id"], name: "index_course_offering_teachers_on_course_offering_id"
    t.index ["teacher_id"], name: "index_course_offering_teachers_on_teacher_id"
  end

  create_table "course_offerings", force: :cascade do |t|
    t.integer "max_students"
    t.boolean "monday"
    t.boolean "tuesday"
    t.boolean "wednesday"
    t.boolean "thursday"
    t.boolean "friday"
    t.string "start_time"
    t.string "end_time"
    t.string "status"
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_offerings_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.integer "course_number"
    t.string "name"
    t.integer "credits"
    t.integer "level"
    t.bigint "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_courses_on_department_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.bigint "school_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_departments_on_school_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.bigint "school_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_teachers_on_school_id"
  end

  add_foreign_key "course_offering_students", "course_offerings"
  add_foreign_key "course_offering_students", "students"
  add_foreign_key "course_offering_teachers", "course_offerings"
  add_foreign_key "course_offering_teachers", "teachers"
  add_foreign_key "course_offerings", "courses"
  add_foreign_key "courses", "departments"
  add_foreign_key "departments", "schools"
  add_foreign_key "teachers", "schools"
end
