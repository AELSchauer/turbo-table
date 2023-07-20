class CourseOffering < ApplicationRecord
  belongs_to :course
  has_many :teachers
  has_many :students
end
