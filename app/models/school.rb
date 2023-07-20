class School < ApplicationRecord
  has_many :departments
  has_many :teachers
end
