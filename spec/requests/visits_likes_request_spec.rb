require 'rails_helper'

RSpec.describe 'VisitsLikes', type: :request do
  # initialize test data
  let!(:user) { create(:organizer) }
  let(:expo) { create(:expo, user: user, likes_count: 10) }

  # Test suite for POST /likes
  describe 'POST /likes' do
    let(:expo) { create(:expo, user: user, likes_count: 10) }

    context 'performing like' do
      before do
        UserExpo.create(user_id: user.id, expo_id: expo.id, liked: false)
        post '/likes',
             params: { liked: true,
                       user_id: user.id,
                       expo_id: expo.id },
             headers: auth_headers(user)
      end

      it 'creates like' do
        expect(Expo.find(expo.id).likes_count).to eq(expo.likes_count + 1)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'performing dislike' do
      before do
        UserExpo.create(user_id: user.id, expo_id: expo.id, liked: true)
        post '/likes',
             params: { liked: false,
                       user_id: user.id,
                       expo_id: expo.id },
             headers: auth_headers(user)
      end

      it 'remove like' do
        expect(Expo.find(expo.id).likes_count).to eq(expo.likes_count - 1)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for POST /visits
  describe 'POST /visits' do

    context 'when the request is valid' do
      before do
        post '/visits',
             params: { user_id: user.id,
                       expo_id: expo.id },
             headers: auth_headers(user)
      end

      it 'creates a visits' do
        expect(Expo.find(expo.id).views_count).to eq(expo.views_count + 1)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before do
        post '/visits',
             params: { user_id: user.id },
             headers: auth_headers(user)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a validation failure message' do
        p response.body.inspect
        expect(response.body).to match(/"Couldn't find Expo without an ID"\]/)
      end
    end
  end
end
