class Student < ApplicationRecord
  has_one :record_book, class_name: 'Student::RecordBook'
  belongs_to :faculty
  has_and_belongs_to_many :courses

  def take_exam(course, grade = 0)
    grade > 0 ? 61 : nil
  end
end
