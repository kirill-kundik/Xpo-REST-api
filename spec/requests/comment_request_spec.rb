require 'rails_helper'

RSpec.describe 'Comments Controller', type: :request do
  # initialize test data
  let!(:user) { create(:user) }
  let!(:comments) { create_list(:comment, 3, user: user) }
  let(:comment_id) { comments.first.id }

  # Test suite for GET /comment
  describe 'GET /comment' do
    # make HTTP get request before each example
    before do
      get '/comment', headers: auth_headers(user)
    end

    it 'returns comments' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /comment/:id
  describe 'GET /comment/:id' do
    before do
      get "/comment/#{comment_id}", headers: auth_headers(user)
    end

    context 'when the record exists' do
      it 'returns the comment' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(comment_id)
        expect(json['text']).to eq(comments.first.text)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:comment_id) { Faker::Number.number digits: 10 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Comment/)
      end
    end
  end

  # Test suite for POST /comment
  describe 'POST /comment' do
    # valid payload
    let(:expo) { create(:expo) }
    let(:comment_text) { Faker::Lorem.paragraph }

    context 'when the request is valid' do
      before do
        post '/comment',
             params: { text: comment_text,
                       user_id: user.id,
                       expo_id: expo.id },
             headers: auth_headers(user)
      end

      it 'creates a comment' do
        expect(json['text']).to eq(comment_text)
        expect(Comment.find(json['id']).text).to eq(comment_text)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before do
        post '/comment',
             params: { user_id: user.id },
             headers: auth_headers(user)
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/"text":\["can't be blank"\]/)
      end
    end
  end

  # Test suite for PUT /comment/:id
  describe 'PUT /comment/:id' do
    let!(:new_text) { Faker::Lorem.paragraph }
    let(:valid_attributes) { { text: new_text } }

    context 'when the record exists' do
      before do
        put(
          "/comment/#{comment_id}",
          params: { text: new_text },
          headers: auth_headers(user)
        )
      end

      it 'updates the record' do
        expect(json['text']).to eq(new_text)
        expect(Comment.find(comment_id).text).to eq(new_text)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:comment_id) { Faker::Number.number digits: 10 }

      before do
        put(
          "/comment/#{comment_id}",
          params: { text: new_text },
          headers: auth_headers(user)
        )
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Comment/)
      end
    end
  end

  # Test suite for DELETE /comment/:id
  describe 'DELETE /comment/:id' do
    before do
      delete "/comment/#{comment_id}",
             headers: auth_headers(user)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
