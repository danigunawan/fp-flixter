class Instructor::SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_course_owner

  def new
    @section = Section.new
  end

  def create
    @section = Section.new section_params.merge(course_id: current_course.id)
    if @section.save
      redirect_to instructor_course_path(current_course)
    else
      render "new", status: :unprocessable_entity
    end
  end

  private
  def current_course
    @current_course ||= Course.find params[:course_id]
  end

  def require_course_owner
    render text: "Not Allowed: A course can only be modified by its owner", status: :unauthorized if current_course.user != current_user
  end

  def section_params
    params.require(:section).permit(:title)
  end
end