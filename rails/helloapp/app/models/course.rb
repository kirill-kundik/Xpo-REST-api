class Course < ApplicationRecord
  has_and_belongs_to_many :students

  validates :name, presence: true, length: { maximum: 30 }
end
