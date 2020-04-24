class VisitsLikesController < ApplicationController
  authorize_resource class: false

  # POST /visits
  def visit
    authorize! :create, UserExpo
    authorize_create! model: UserExpo
    @user_expo = UserExpo.find_or_create_by(
      user_id: params[:user_id], expo_id: params[:expo_id]
    )
    @user_expo.perform_visit
    render_resource @user_expo
  end

  # POST /likes
  def like
    @user_expo = UserExpo.find_by!(
      user_id: params[:user_id], expo_id: params[:expo_id]
    )
    authorize! :update, @user_expo
    liked = params[:liked] == 'true'
    unless liked == @user_expo.liked
      expo = Expo.find(@user_expo.expo_id)
      if liked
        expo.update({ likes_count: expo.likes_count + 1 })
      elsif expo.likes_count.positive?
        expo.update({ likes_count: expo.likes_count - 1 })
      end
    end
    @user_expo.update(visit_like_params)
    render_resource @user_expo
  end

  private

  def visit_like_params
    params.permit :user_id, :expo_id, :liked
  end
end
