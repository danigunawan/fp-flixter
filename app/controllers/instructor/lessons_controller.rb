class Instructor::LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_course_owner

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new lesson_params.merge(section_id: current_section.id)
    if @lesson.save
      redirect_to instructor_course_path(current_section.course)
    else
      render "new", status: :unprocessable_entity
    end
  end

  private
  def current_section
    return @current_section ||= Section.find(params[:section_id])
  end

  def require_course_owner
    return render text: "Not Allowed: A course can only be modified by the course owner", status: :unauthorized if current_section.course.user != current_user
  end

  def lesson_params
    params.require(:lesson).permit(:title, :subtitle)
  end
end