class Student < ApplicationRecord
  has_one :record_book, class_name: 'Student::RecordBook'
  belongs_to :faculty
  has_and_belongs_to_many :courses
end
