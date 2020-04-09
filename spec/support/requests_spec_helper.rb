module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end

  # authenticate user
  def authenticate_user(user)
    post '/auth/login', params: { login: user.login, password: user.password }
    json['token']
  end
end
