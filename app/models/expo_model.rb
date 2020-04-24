class ExpoModel < ApplicationRecord
  belongs_to :expo

  validates :ar_model_url, presence: true
  validates :marker_url, presence: true
end
