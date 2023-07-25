class Course < ApplicationRecord
  belongs_to :department
  has_one :school, through: :department
  has_many :course_offerings
end
