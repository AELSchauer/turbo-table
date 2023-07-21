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
    params.try(:[], :filter).try(:permit!)

    filter_by_credits if params.try(:[], :filter).try(:[], :credits).present?
  end

  def filter_by_credits
    @courses = @courses.where(credits: params[:filter][:credits].keys)
  end

  def sort_courses
    @courses = @courses.order("schools.name ASC", "departments.code ASC", "course_number ASC")
  end

  def paginate_courses
    @courses = Kaminari.paginate_array(@courses).page(params[:page]).per(25)
  end
end

