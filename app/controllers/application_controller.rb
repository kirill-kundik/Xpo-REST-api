class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include CreateAccessValidation

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: %i[name email organizer_role superadmin_role]
    )
  end
end