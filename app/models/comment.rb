class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :expo

  validates :text, presence: true, allow_blank: false, allow_nil: false
  validates :likes_count, {
    presence: true, allow_nil: false,
    numericality: {
      greater_than_or_equal_to: 0,
      only_integer: true
    }
  }
end
