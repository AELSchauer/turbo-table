class School < ApplicationRecord
  has_many :departments
  has_many :teachers

  def self.dropdown_options
    self.joins(:departments)
        .pluck('schools.name', 'departments.name', 'departments.id')
        .uniq
        .group_by(&:first)
        .transform_values { |department_arr| department_arr.map { |a| a.slice(1..-1)} }
  end
end
