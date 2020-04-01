class Course < ApplicationRecord
  has_and_belongs_to_many :students

  validates :name, presence: true, length: { maximum: 30 }

  before_save :do_smth

  def do_smth
    puts 'before save...'
    self.name = "#{self.name} he-he-he"
  end

  def do_other_thing
    puts 'hello'
  end

  def do_hard_work
    puts 'doing smth hard...'
    sleep 10
    puts 'finished'
  end
end
