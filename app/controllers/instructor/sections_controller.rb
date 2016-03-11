class Instructor::SectionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @section = Section.new
  end

  def create
    @section = Section.new section_params.merge(course_id: params[:course_id])
    if @section.save
      redirect_to instructor_course_path(params[:course_id])
    else
      render "new", status: :unprocessable_entity
    end
  end

  private
  def section_params
    params.require(:section).permit(:title)
  end
end