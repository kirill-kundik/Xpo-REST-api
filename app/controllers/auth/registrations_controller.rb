class Auth::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    if resource.save
      resource.send_welcome_email
    end
    render_resource(resource)
  end
end
