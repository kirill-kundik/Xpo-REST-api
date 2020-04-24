require 'rails_helper'

RSpec.describe 'POST /auth/signup', type: :request do
  let(:url) { '/auth/signup' }
  let(:params) do
    {
      user: {
        login: 'test_user',
        name: 'test user',
        password: 'password',
        email: 'test@test.com'
      }
    }
  end

  context 'when user is unauthenticated' do
    before { post url, params: params }

    it 'returns 200' do
      expect(response.status).to eq 200
    end

    it 'returns a new user' do
      expect(json['login']).to eq params[:user][:login]
    end
  end

  context 'when user already exists' do
    before do
      create :user, login: params[:user][:login]
      post url, params: params
    end

    it 'returns bad request status' do
      expect(response.status).to eq 400
    end

    it 'returns validation errors' do
      expect(json['errors']['login']).to(
        eq(['has already been taken'])
      )
    end
  end
end
