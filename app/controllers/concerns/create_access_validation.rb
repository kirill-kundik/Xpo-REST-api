module CreateAccessValidation
  def authorize_create!(
    user_id: params[:user_id],
    message: 'Forbidden to create with another user_id',
    action: :create,
    model: nil
  )
    if user_id.to_i != current_user.id
      raise CanCan::AccessDenied.new(
        message,
        action,
        model
      )
    end
  end
end
