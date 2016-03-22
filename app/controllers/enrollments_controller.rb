class EnrollmentsController < ApplicationController
  before_action :authenticate_user!

  def create
    course = Course.find params[:course_id]

    unless course.cost.zero?
      amount = (course.cost * 100).to_i # Amount in cents
      Stripe::Charge.create(
        amount: amount,
        source: params[:stripe_token],
        currency: "usd",
        description: "Enrollment in Course #{course.id}: #{course.title}",
        metadata: {user_id: current_user.id},
        statement_descriptor: "Learnster enrollment"
      )
    end

    Enrollment.create user_id: current_user.id, course_id: course.id
    redirect_to course_path(course)
    
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to course_path(course)

  rescue Stripe::StripeError => e
    flash[:error] = "Something went wrong, and you were not charged. Please try again later."
    redirect_to course_path(course)
  end
end