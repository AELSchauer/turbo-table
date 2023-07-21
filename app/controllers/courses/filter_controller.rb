class Courses::FilterController < ApplicationController
  def show
    filter_params
  end

  def filter_params
    params.try(:[], :filter).try(:[], :credits).try(:permit!)
  end
end

