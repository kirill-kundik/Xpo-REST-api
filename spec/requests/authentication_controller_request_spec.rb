require 'rails_helper'

RSpec.describe 'AuthenticationControllers', type: :request do
  before(:each) do
    @user = create(:user)
  end

  describe 'POST /auth/login: empty request' do
    before { post '/auth/login' }

    it 'should not returns token' do
      expect(json).not_to be_nil
      expect(json['error']).to eq('unauthorized')
    end
    it 'should return status code 401' do
      expect(response).to have_http_status(401)
    end
  end

  describe 'POST /auth/login: only login in params' do
    before { post '/auth/login', params: { login: @user.login } }

    it 'should not returns token' do
      expect(json).not_to be_nil
      expect(json['error']).to eq('unauthorized')
    end
    it 'should return status code 401' do
      expect(response).to have_http_status(401)
    end
  end

  describe 'POST /auth/login: only pass in params' do
    before { post '/auth/login', params: { password: @user.password } }

    it 'should not returns token' do
      expect(json).not_to be_nil
      expect(json['error']).to eq('unauthorized')
    end
    it 'should return status code 401' do
      expect(response).to have_http_status(401)
    end
  end

  describe 'POST /auth/login: invalid login' do
    before { post '/auth/login', params: { login: @user.login + 'he-he-he', password: @user.password } }

    it 'should not returns token' do
      expect(json).not_to be_nil
      expect(json['error']).to eq('unauthorized')
    end
    it 'should return status code 401' do
      expect(response).to have_http_status(401)
    end
  end

  describe 'POST /auth/login: invalid pass' do
    before { post '/auth/login', params: { login: @user.login, password: @user.password + 'he-he-he' } }

    it 'should not returns token' do
      expect(json).not_to be_nil
      expect(json['error']).to eq('unauthorized')
    end
    it 'should return status code 401' do
      expect(response).to have_http_status(401)
    end
  end

  describe 'POST /auth/login: successful' do
    before do
      post '/auth/login', params: { login: @user.login, password: @user.password }
    end

    it 'should returns token' do
      expect(json).not_to be_nil
      expect(json['token']).to be_a(String)
    end
    it 'should return status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
