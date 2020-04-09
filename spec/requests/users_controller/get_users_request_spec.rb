require 'rails_helper'

RSpec.describe 'GetUsersController', type: :request do
  let!(:users) { create_list(:user, 5) }

  describe 'GET /users' do
    context 'with an unauthorized user' do
      before { get '/users' }
      it 'returns unauthorized' do
        expect(response).to have_http_status(401)
      end
    end

    context 'with authorized user' do
      it 'returns users' do
        token = authenticate_user(users.first)
        get '/users', headers: { Authorization: token }

        expect(json).not_to be_empty
        expect(json.size).to eq(:users.size)

        rand_user_from_response = User.find_by_login json.sample['login']
        rand_user_from_factory = (users.select do |elem|
          elem.login == rand_user_from_response.login
        end).first

        expect(rand_user_from_response).to eq(rand_user_from_factory)
        expect(response).to have_http_status(200)
      end
    end
  end

end
