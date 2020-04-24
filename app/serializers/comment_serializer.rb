class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :expo_id, :text, :likes_count,
             :created_at, :updated_at, :user_name

  def user_name
    @object.user.name
  end
end