class CourseOfferingStudent < ApplicationRecord
  belongs_to :student
  belongs_to :course_offering

  GRADES = %w(A+ A A- B+ B B- C+ C C- D+ D D- F I W)
end
