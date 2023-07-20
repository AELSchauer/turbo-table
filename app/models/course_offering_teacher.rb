class CourseOfferingTeacher < ApplicationRecord
  belongs_to :teacher
  belongs_to :course_offering

  ROLES = %w(primary support)
end
