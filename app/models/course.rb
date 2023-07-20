class Course < ApplicationRecord
  belongs_to :department
  has_many :teachers
  has_many :students
end
