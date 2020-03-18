class CoursesController < ApplicationController
  protect_from_forgery except: %i[update destroy]
  before_action :load_course, only: %i[update destroy]

  def index
    @courses = ::Course.includes(:students).map do |course|
      {id: course.id, name: course.name, students_count: course.students.size}
    end
  end

  def destroy
    render json: {success: @course.destroy}
  end

  def update
    @course.attributes = course_params
    @course.save
  end

  private

  def load_course
    @course = ::Course.find params[:id]
  end

  def course_params
    params.permit(:name)
  end
end
