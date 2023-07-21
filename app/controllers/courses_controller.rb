class CoursesController < ApplicationController
  def index
    @courses = Course.includes(:department, department: :school)
      .all
      .order("schools.name ASC", "departments.code ASC", "course_number ASC")
      .limit(50)
  end

  def filter
  end
end

