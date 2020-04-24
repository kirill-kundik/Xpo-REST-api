class ExpoModelsController < ApplicationController
  load_and_authorize_resource

  # GET /expo_models
  def index
    render_resource @expo_models
  end

  # POST /expo_models
  def create
    expo = Expo.find expo_model_params[:expo_id]
    authorize_create! user_id: expo.user.id, model: ExpoModel
    @expo_model = ExpoModel.create expo_model_params
    render_resource @expo_model
  end

  # GET /expo_models/{id}
  def show
    render_resource @expo_model
  end

  # PUT /expo_models/{id}
  def update
    @expo_model.update expo_model_params
    render_resource @expo_model
  end

  # DELETE /expo_models/{id}
  def destroy
    @expo_model.destroy
    render_resource @expo_model
  end

  private

  def expo_model_params
    params.permit :ar_model_url, :marker_url, :expo_id
  end
end
