class CoursesController < ApplicationController
  def index
    @courses = Course.page(params[:page]).per(3)
    return redirect_to courses_path(@courses.num_pages) if params[:page] && params[:page].to_i > @courses.num_pages 
  end

  def show
    @course = Course.find(params[:id])
  end
end