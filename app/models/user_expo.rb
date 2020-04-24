# frozen_string_literal: true

class UserExpo < ApplicationRecord
  belongs_to :user
  belongs_to :expo

  def perform_visit
    expo = Expo.find(expo_id)
    expo.update({ views_count: expo.views_count + 1 })
  end
end
