class Instructor::SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_course_owner

  def create
    @section = Section.new section_params.merge(course_id: current_course.id)
    if @section.save
      redirect_to instructor_course_path(current_course)
    else
      @course = current_course # Provide the instance variable expected by the instructor course view
      render "instructor/courses/show", status: :unprocessable_entity
    end
  end

  def update
    section = Section.find params[:id]
    return head :forbidden if section.course != current_course # Protects against course/section mismatch
    section.update_attributes(sort_order_position: params[:sort_order_position]) ? head(:ok) : head(:unprocessable_entity)
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