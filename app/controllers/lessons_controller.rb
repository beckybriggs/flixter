class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course, only: [:show]

  def show
  end

  private

  def require_authorized_for_current_course
    @course = current_lesson.section.course
    if !current_user.enrolled_in?(@course)
      redirect_to course_path(@course), alert: 'You must enroll in the course before viewing the lesson.'
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
