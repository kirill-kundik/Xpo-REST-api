class CoursesController < ApplicationController
  layout 'courses'
  protect_from_forgery except: %i[update destroy]
  before_action :load_course, only: %i[update destroy edit]
  before_action :authenticate_user!

  def index
    @courses = ::Course.accessible_by(current_ability).includes(:students)
  end

  def destroy
    render json: {success: @course.destroy}
  end

  def update
    authorize! :update, @course
    @course.attributes = course_params
    @course.save
    redirect_to :courses
  end

  def edit
  end

  private

  def load_course
    @course = ::Course.find params[:id]
  end

  def course_params
    params.require(:course).permit(:name)
  end
end
