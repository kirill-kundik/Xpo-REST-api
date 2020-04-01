class ProcessCourseWorker
  include ::Sidekiq::Worker

  def perform(course_id)
    @course = ::Course.find course_id
    @course.do_hard_work
  end
end
