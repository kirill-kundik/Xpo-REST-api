class ExpoSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image_url, :start_time, :end_time,
             :location_name, :views_count, :likes_count, :user_id, :created_at,
             :updated_at, :organizer_name

  has_many :comments
  has_many :expo_models

  def organizer_name
    @object.user.name
  end
end
