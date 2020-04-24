class ExposController < ApplicationController
  load_and_authorize_resource

  # GET /expos
  def index
    render_resource @expos
  end

  # POST /expos
  def create
    authorize_create! model: Expo
    @expo = Expo.create expo_params
    render_resource @expo
  end

  # GET /expos/{id}
  def show
    render_resource @expo
  end

  # PUT /expos/{id}
  def update
    @expo.update expo_params
    render_resource @expo
  end

  # DELETE /expos/{id}
  def destroy
    @expo.destroy
    render_resource @expo
  end

  private

  def expo_params
    params.permit(
      :name, :description, :image_url, :start_time,
      :end_time, :location_name, :user_id
    )
  end
end
