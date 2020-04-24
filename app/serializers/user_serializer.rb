class UserSerializer < ActiveModel::Serializer
  attributes :id, :login, :name, :email, :superadmin_role,
             :organizer_role, :user_role, :created_at, :updated_at

  has_many :expos, serializer: ExpoSerializer
end
