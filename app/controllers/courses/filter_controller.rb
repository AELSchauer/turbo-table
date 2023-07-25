class Courses::FilterController < ApplicationController
  def show
    filter_params
  end

  def filter_params
    params.dig(:filter).try(:permit!)
    params.dig(:filter, :credits).try(:permit!)
    params.dig(:filter, :department).try(:permit!)
  end
end
