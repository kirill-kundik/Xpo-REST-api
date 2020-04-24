class UserExpoSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :expo_id, :liked, :created_at, :updated_at
end
