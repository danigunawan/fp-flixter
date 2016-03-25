class Instructor::LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_course_owner

  def create
    @lesson = Lesson.new lesson_params.merge(section_id: current_section.id)
    if @lesson.save
      redirect_to instructor_course_path(current_section.course)
    else
      @course = current_section.course
      @section = Section.new
      @validation_section = current_section
      render "instructor/courses/show", status: :unprocessable_entity
    end
  end

  def update
    lesson = Lesson.find params[:id]
    return head :forbidden if lesson.section != current_section # Protects against section/lesson mismatch
    lesson.update_attributes(sort_order_position: params[:sort_order_position]) ? head(:ok) : head(:unprocessable_entity)
  end

  private
  def current_section
    @current_section ||= Section.find params[:section_id]
  end

  def require_course_owner
    render text: "Not Allowed: A course can only be modified by its owner", status: :unauthorized if current_section.course.user != current_user
  end

  def lesson_params
    params.require(:lesson).permit(:title, :subtitle, :video)
  end
end