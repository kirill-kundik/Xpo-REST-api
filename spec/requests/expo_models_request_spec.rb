require 'rails_helper'

RSpec.describe "ExpoModels", type: :request do
  # initialize test data
  let!(:user) { create(:organizer) }
  let!(:expo) { create(:expo, user: user) }
  let!(:expo_models) { create_list(:expo_model, 3, expo: expo) }
  let(:model_id) { expo_models.first.id }

  describe 'GET /expo_models' do
    before do
      get '/expo_models', headers: auth_headers(user)
    end

    it 'returns expo_models' do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /expo_models/:id' do
    before do
      get "/expo_models/#{model_id}", headers: auth_headers(user)
    end

    context 'when the record exists' do
      it 'returns the expo_models' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(model_id)
        expect(json['ar_model_url']).to eq(expo_models.first.ar_model_url)
      end

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exists' do
      let(:model_id) { Faker::Number.number digits: 10 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find ExpoModel/)
      end
    end
  end

  describe 'POST /expo_models' do
    let!(:expo) { create(:expo, user: user) }
    let(:ar_model_url) { Faker::Lorem.paragraph }
    let(:marker_url) { Faker::Lorem.paragraph }

    context 'when the request is valid' do
      before do
        post '/expo_models',
             params: { expo_id: expo.id,
                       ar_model_url: ar_model_url,
                       marker_url: marker_url },
             headers: auth_headers(user)
      end

      it 'creates a expo_models' do
        expect(json['ar_model_url']).to eq(ar_model_url)
        expect(json['marker_url']).to eq(marker_url)
        expect(ExpoModel.find(json['id']).ar_model_url).to eq(ar_model_url)
        expect(ExpoModel.find(json['id']).marker_url).to eq(marker_url)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before do
        post '/expo_models',
             params: { expo_id: expo.id,
                       ar_model_url: ar_model_url },
             headers: auth_headers(user)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/"marker_url":\["can't be blank"\]/)
      end
    end

    describe 'PUT /expo_models/:id' do
      let!(:new_model) { Faker::Lorem.paragraph }
      let!(:new_marker) { Faker::Lorem.paragraph }

      context 'when the record exists' do
        before do
          put(
            "/expo_models/#{model_id}",
            params: { ar_model_url: new_model,
                      marker_url: new_marker },
            headers: auth_headers(user)
          )
        end

        it 'updates the record' do
          expect(json['ar_model_url']).to eq(new_model)
          expect(json['marker_url']).to eq(new_marker)
          expect(ExpoModel.find(json['id']).ar_model_url).to eq(new_model)
          expect(ExpoModel.find(json['id']).marker_url).to eq(new_marker)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end

      context 'when the record does not exist' do
        let(:model_id) { Faker::Number.number digits: 10 }

        before do
          put(
            "/expo_models/#{model_id}",
            params: { ar_model_url: new_model,
                      marker_url: new_marker },
            headers: auth_headers(user)
          )
        end

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a not found message' do
          expect(response.body).to match(/Couldn't find ExpoModel/)
        end
      end

      describe 'DELETE /expo_models/:id' do
        before do
          delete "/expo_models/#{model_id}",
                 headers: auth_headers(user)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end
    end
  end
end
