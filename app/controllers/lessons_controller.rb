class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_enrolled_user_or_owner

  def show
  end

  private
  def current_lesson
    @lesson ||= Lesson.find params[:id]
  end

  def require_enrolled_user_or_owner
    current_course = current_lesson.section.course
    redirect_to course_path(current_course), alert: "You must be enrolled in this course to access the lessons." unless current_user.enrolled_in?(current_course) || current_user.courses.include?(current_course)
  end
end