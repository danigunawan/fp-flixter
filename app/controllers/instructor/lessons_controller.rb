class Instructor::LessonsController < ApplicationController
  def new
    @lesson = Lesson.new
  end

  def create
    section = Section.find params[:section_id]
    @lesson = Lesson.new lesson_params.merge(section_id: section.id)
    if @lesson.save
      redirect_to instructor_course_path(section.course)
    else
      render "new", status: :unprocessable_entity
    end
  end

  private
  def lesson_params
    params.require(:lesson).permit(:title, :subtitle)
  end
end