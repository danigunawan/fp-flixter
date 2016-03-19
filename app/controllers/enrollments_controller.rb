class EnrollmentsController < ApplicationController
  before_action :authenticate_user!

  def create
    Enrollment.create user_id: current_user.id, course_id: params[:course_id]
    redirect_to course_path(params[:course_id])
  end
end