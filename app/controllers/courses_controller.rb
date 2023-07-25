class CoursesController < ApplicationController
  def index
    load_courses
    filter_courses
    sort_courses
    paginate_courses
  end

  private

  def load_courses
    @courses = Course
      .includes(:department, department: :school)
      .all
  end

  def filter_courses
    params.dig(:filter).try(:permit!)

    filter_by_credits if params.dig(:filter, :credits).present?
    filter_by_department if params.dig(:filter, :department).present?
  end

  def filter_by_credits
    @courses = @courses.where(credits: params[:filter][:credits].keys)
  end

  def filter_by_department
    @courses = @courses.where(department_id: params[:filter][:department])
  end

  def sort_courses
    @courses = @courses.order("schools.name ASC", "departments.code ASC", "course_number ASC")
  end

  def paginate_courses
    @courses = Kaminari.paginate_array(@courses).page(params[:page]).per(25)
  end
end
