module Response
  def render_resource(resource, status = nil)
    if resource.respond_to?(:errors) && !resource.errors.empty?
      render json: {
        errors: resource.errors
      }, status: status.nil? ? :bad_request : status
    else
      render json: resource, status: :ok
    end
  end
end
