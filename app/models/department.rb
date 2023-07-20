class Department < ApplicationRecord
  belongs_to :school
  has_many :courses
end
