class CoursesController < ApplicationController
  def index
    @courses = Course.page(params[:page]).per(3)
  end
end