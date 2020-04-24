class UsersController < ApplicationController
  load_resource find_by: :login # will use find_by_login!(params[:id])
  authorize_resource

  # GET /users/{username}
  def show
    render_resource @user
  end

  # PUT /users/{username}
  def update
    @user.update user_params
    if user_params.respond_to? :password
      @user.reset_password(user_params[:password], user_params[:password])
    end
    render_resource @user
  end

  # DELETE /users/{username}
  def destroy
    @user.destroy
    render_resource @user
  end

  private

  def user_params
    params.permit :login, :name, :password, :email
  end
end
