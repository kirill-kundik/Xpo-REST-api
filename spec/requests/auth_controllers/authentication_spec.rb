require 'rails_helper'

RSpec.describe 'POST /auth/login', type: :request do
  let(:user) { create(:user) }
  let(:url) { '/auth/login' }
  let(:params) do
    {
      user: {
        login: user.login,
        password: user.password
      }
    }
  end

  context 'when params are correct' do
    before do
      post url, params: params
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns JTW token in authorization header' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns valid JWT token' do
      expect(decoded_jwt_token.first['sub']).to be_present
    end
  end

  context 'when login params are incorrect' do
    before { post url }

    it 'returns unathorized status' do
      expect(response.status).to eq 401
    end
  end
end

RSpec.describe 'DELETE /auth/logout', type: :request do
  let(:url) { '/auth/logout' }
  let!(:user) { create(:user) }
  it 'returns 204, no content' do
    delete url, headers: auth_headers(user)
    expect(response).to have_http_status(200)
  end
end