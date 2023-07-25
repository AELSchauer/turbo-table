class Courses::FilterController < ApplicationController
  def show
    filter_params
  end

  def filter_params
    params.dig(:filter, :credits).try(:permit!)
  end
end
