require 'rails_helper'

RSpec.describe 'Expos', type: :request do
  let!(:user) { create(:organizer) }
  let!(:expos) { create_list(:expo, 3, user: user) }
  let(:expo_id) { expos.first.id }

  # Test suite for GET /expo
  describe 'GET /expos' do
    # make HTTP get request before each example
    before do
      get '/expos', headers: auth_headers(user)
    end

    it 'returns expo' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /expo/:id
  describe 'GET /expos/:id' do
    before do
      get "/expos/#{expo_id}", headers: auth_headers(user)
    end

    context 'when the record exists' do
      it 'returns the expo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(expo_id)
        expect(json['name']).to eq(expos.first.name)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:expo_id) { Faker::Number.number digits: 10 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Expo/)
      end
    end
  end

  # Test suite for POST /expo
  describe 'POST /expos' do
    # valid payload
    let(:user) { create(:organizer) }
    let(:name) { Faker::Lorem.words.join(' ') }
    let(:description) { Faker::Lorem.paragraph }
    let(:image_url) { Faker::Internet.url }
    let(:start_time) { Faker::Time.forward }
    let(:end_time) { Faker::Time.forward }
    let(:location_name) { Faker::Nation.capital_city }
    let(:views_count) { Faker::Number.number(digits: 3) }

    context 'when the request is valid' do
      before do
        post '/expos',
             params: { user_id: user.id,
                       name: name,
                       description: description,
                       image_url: image_url,
                       start_time: start_time,
                       end_time: end_time,
                       location_name: location_name,
                       views_count: views_count },
             headers: auth_headers(user)
      end

      it 'creates a expo' do
        expect(json['name']).to eq(name)
        expect(Expo.find(json['id']).name).to eq(name)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before do
        post '/expos',
             params: { user_id: user.id,
                       name: name },
             headers: auth_headers(user)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/"description":\["can't be blank"\]/)
      end
    end
  end

  # Test suite for PUT /expo/:id
  describe 'PUT /expos/:id' do
    let(:new_name) { Faker::Lorem.words.join(' ') }
    let(:valid_attributes) { { name: new_name, user_id: user.id } }

    context 'when the record exists' do
      before do
        put(
          "/expos/#{expo_id}",
          params: valid_attributes,
          headers: auth_headers(user)
        )
      end

      it 'updates the record' do
        expect(json['name']).to eq(new_name)
        expect(Expo.find(expo_id).name).to eq(new_name)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:expo_id) { Faker::Number.number digits: 10 }

      before do
        put(
          "/expos/#{expo_id}",
          params: valid_attributes,
          headers: auth_headers(user)
        )
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Expo/)
      end
    end
  end

  # Test suite for DELETE /comment/:id
  describe 'DELETE /expo/:id' do
    before do
      delete "/expos/#{expo_id}",
             headers: auth_headers(user)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
