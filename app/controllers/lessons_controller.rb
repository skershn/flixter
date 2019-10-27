class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson, only: [:show]
  

  def show
    @lesson = Lesson.find(params[:id])
  end

  def require_authorized_for_current_lesson
    if current_lesson.section.course.user != current_user
      redirect_to course_path, alert: 'You must be enrolled in this course to view this page'
    end
  end

  private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
