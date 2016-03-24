class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @enrolled_courses = current_user.enrolled_courses.page(params[:enrolled_page]).per(3) 
    @taught_courses = current_user.courses.page(params[:taught_page]).per(3)

    if params[:enrolled_page] && params[:enrolled_page].to_i > @enrolled_courses.num_pages
      params[:taught_page] ? redirect_to(both_page_dashboard_path(@enrolled_courses.num_pages, params[:taught_page])) : redirect_to(enrolled_page_dashboard_path(@enrolled_courses.num_pages))
    elsif params[:taught_page] && params[:taught_page].to_i > @taught_courses.num_pages
      params[:enrolled_page] ? redirect_to(both_page_dashboard_path(params[:enrolled_page], @taught_courses.num_pages)) : redirect_to(taught_page_dashboard_path(@taught_courses.num_pages))
    end
  end
end