class Expo < ApplicationRecord
  validate :time_is_valid_datetime

  belongs_to :user
  has_many :user_expos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :expo_models, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :image_url, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :location_name, presence: true
  validates :views_count, {
    presence: true, numericality:
      { only_integer: true, greater_than_or_equal_to: 0 }
  }
  validates :likes_count, {
    presence: true, numericality:
      { only_integer: true, greater_than_or_equal_to: 0 }
  }

  def time_is_valid_datetime
    if start_time.class != ActiveSupport::TimeWithZone
      errors.add(:start_time, 'start_time must be a valid datetime')
    end

    if end_time.class != ActiveSupport::TimeWithZone
      errors.add(:end_time, 'end_time must be a valid datetime')
    end
  end

  def statistics(date)
    last_comments = comments.where('created_at >= ?', date)
    last_likes = UserExpo.where(expo_id: id).where('updated_at >= ?', date)
    {
      name: name,
      total_likes: likes_count,
      total_views: views_count,
      total_comments: comments.size,
      last_likes: last_likes.size,
      last_comments: last_comments.map do |comment|
        {
          user_login: comment.user.login,
          text: comment.text,
          likes_count: comment.likes_count,
          created_at: comment.created_at.strftime('%d.%m %H:%M')
        }
      end.compact
    }
  end
end
