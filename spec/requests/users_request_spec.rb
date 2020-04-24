require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  # initialize test data
  let!(:user) { create(:user) }
  let!(:users) { create_list(:user, 3) }
  let!(:user_id) { users.first.login }

  # Test suite for GET /comment/:id
  describe 'GET /users/:id' do
    before do
      get "/users/#{user_id}", headers: auth_headers(user)
    end

    context 'when the record exists' do
      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['login']).to eq(users.first.login)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { Faker::Number.number digits: 10 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for PUT /users/:id
  describe 'PUT /users/:id' do
    let(:new_login) { Faker::Internet.username }
    let(:valid_attributes) { { login: new_login } }

    context 'when the record exists' do
      before do
        put "/users/#{user.login}",
            params: valid_attributes,
            headers: auth_headers(user)
      end

      it 'updates the record' do
        expect(json['login']).to eq(new_login)
        expect(User.find(user.id).login).to eq(new_login)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { Faker::Number.number digits: 10 }

      before do
        put(
          "/users/#{user_id}",
          params: valid_attributes,
          headers: auth_headers(user)
        )
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for DELETE /users/:id
  describe 'DELETE /users/:id' do
    context 'user cannot delete another user' do
      before do
        another_user = create(:user)
        delete "/users/#{another_user.login}",
               headers: auth_headers(user)
      end

      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
    end
    context 'user can delete himself' do
      before do
        user = create(:user)
        delete "/users/#{user.login}",
               headers: auth_headers(user)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

  end

end
