# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'csv'

start_run_time = Time.now

def format_time(time, time_of_day)
  if time.length == 4
    hour = time.slice(0..1).to_i
    minute = time.slice(2..3).to_i
  elsif time.length == 3
    hour = time.slice(0).to_i
    minute = time.slice(1..2).to_i
  else
    hour = time.to_i
    minute = 0
  end
  hour += 12 if time_of_day == "PM" && hour != 12
  sprintf("%02i:%02i",hour,minute)
end

table = CSV.parse(File.read("./db/seeds/course-catalog.csv", headers: true))
student_list = table.slice(1..-1).map(&:first).uniq.each_with_index.map do |subject, idx|
  Student.upsert_all(1200.times.map{ { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name }})
  [subject, Student.offset(1200 * idx)]
end.to_h


CSV.foreach("./db/seeds/course-catalog.csv", headers: true) do |row|
  next if row["Time"] == "ARR"
  puts row["Class ID"]

  school = School.find_or_create_by(name: row["Acad Group"])
  department = Department.find_or_create_by(name: row["Subject"], code: row["Subject Code"], school: school)
  course = Course.find_or_create_by(
    department: department,
    course_number: row["Course Nbr"],
    level: row["Course Nbr"].to_i / 100 * 100,
    name: row["Course Title"],
    credits: row["Credits"].to_i
  )

  time_regex = /(?<start_time>\d{1,4})-(?<end_time>\d{1,4})(?<time_of_day>AM|PM)/
  scheduled_time = row["Time"].match(time_regex)
  if scheduled_time[:start_time] > scheduled_time[:end_time] && scheduled_time[:time_of_day] == "PM"
    start_time = format_time(scheduled_time[:start_time],"AM")
    end_time = format_time(scheduled_time[:end_time], "PM")
  else
    start_time = format_time(scheduled_time[:start_time], scheduled_time[:time_of_day])
    end_time = format_time(scheduled_time[:end_time], scheduled_time[:time_of_day])
  end

  teachers = row["Instructor"].try(:split, ", ") || [Faker::Name.last_name]
  teachers.each do |teacher_name|
    teacher = Teacher.find_by(last_name: teacher_name, school: school) || Teacher.create(last_name: teacher_name, school: school, first_name: Faker::Name.first_name) 
    max_students = rand(10..100)
    course_offering = CourseOffering.create(
      course: course,
      max_students: max_students,
      monday: row["Day"].index("M").present?,
      tuesday: row["Day"].index("T").present?,
      wednesday: row["Day"].index("W").present?,
      thursday: row["Day"].index("TH").present?,
      friday: row["Day"].index("F").present?,
      start_time: start_time,
      end_time: end_time,
      status: "complete"
    )
    CourseOfferingTeacher.create(course_offering: course_offering, teacher: teacher, role: :primary)

    actual_students = rand(((max_students*0.8).to_i)..max_students)
    CourseOfferingStudent.upsert_all(
      student_list[row["Acad Group"]].sample(actual_students).map { |student|
        { student_id: student.id, course_offering_id: course_offering.id, grade: CourseOfferingStudent::GRADES.sample }
      }
    )
  end
end

puts Time.now - start_run_time