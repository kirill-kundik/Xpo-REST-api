module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end

  # authenticate user
  def auth_headers(user)
    sign_in user
    Devise::JWT::TestHelpers.auth_headers({}, user)
  end

  def decoded_jwt_token
    token_from_request = response.headers['Authorization'].split(' ').last
    JWT.decode(token_from_request, ENV['DEVISE_SECRET_KEY'], true)
  end
end
