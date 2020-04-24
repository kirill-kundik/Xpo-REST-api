module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { errors: [e.message] }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { errors: [e.message] }, status: :bad_request
    end

    rescue_from CanCan::AccessDenied do |e|
      render json: { errors: [e.message] }, status: :forbidden
    end
  end
end
