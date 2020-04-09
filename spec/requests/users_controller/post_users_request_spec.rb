require 'rails_helper'

RSpec.describe 'PostUsersController', type: :request do
  let!(:users) { create_list(:user, 5) }

  describe 'POST /users: empty request' do
    before { post '/users' }

    it 'should return json' do
      expect(json).to_not be_nil
      expect(json).to be_a(Hash)
    end

    it 'should return errors' do
      expect(json['errors']).to_not be_nil
      expect(json['errors']).to be_a(Array)
      expect(json['errors'].size).to eq(4)
    end

    it 'should return 400 Bad Request' do
      expect(response).to have_http_status(400)
    end
  end

  describe 'POST /users: blank login' do
    before do
      password = Faker::Internet.password(min_length: 6)
      post '/users', params: {
        name: Faker::Lorem.word,
        password: password,
        password_confirmation: password
      }
    end

    it 'should return json' do
      expect(json).to_not be_nil
      expect(json).to be_a(Hash)
    end

    it 'should return errors' do
      expect(json['errors']).to_not be_nil
      expect(json['errors']).to be_a(Array)
      expect(json['errors'].size).to eq(1)
    end

    it 'should return error "Login can\'t be blank"' do
      expect(json['errors']).to eq(['Login can\'t be blank'])
    end

    it 'should return 400 Bad Request' do
      expect(response).to have_http_status(400)
    end
  end

  describe 'POST /users: blank name' do
    before do
      password = Faker::Internet.password(min_length: 6)
      post '/users', params: {
        login: Faker::Internet.username,
        password: password,
        password_confirmation: password
      }
    end

    it 'should return json' do
      expect(json).to_not be_nil
      expect(json).to be_a(Hash)
    end

    it 'should return errors' do
      expect(json['errors']).to_not be_nil
      expect(json['errors']).to be_a(Array)
      expect(json['errors'].size).to eq(1)
    end

    it 'should return error "Name can\'t be blank"' do
      expect(json['errors']).to eq(['Name can\'t be blank'])
    end

    it 'should return 400 Bad Request' do
      expect(response).to have_http_status(400)
    end
  end

  describe 'POST /users: blank password' do
    before do
      password = Faker::Internet.password(min_length: 6)
      post '/users', params: {
        login: Faker::Internet.username,
        name: Faker::Lorem.word,
        password_confirmation: password
      }
    end

    it 'should return json' do
      expect(json).to_not be_nil
      expect(json).to be_a(Hash)
    end

    it 'should return errors' do
      expect(json['errors']).to_not be_nil
      expect(json['errors']).to be_a(Array)
      expect(json['errors'].size).to eq(3)
    end

    it 'should return specific error array' do
      expect(json['errors']).to eq(['Password can\'t be blank', 'Password is too short (minimum is 6 characters)', 'Password confirmation doesn\'t match Password'])
    end

    it 'should return 400 Bad Request' do
      expect(response).to have_http_status(400)
    end
  end

  describe 'POST /users: non-confirmed password' do
    before do
      password = Faker::Internet.password(min_length: 6)
      post '/users', params: {
        login: Faker::Internet.username,
        name: Faker::Lorem.word,
        password: password
      }
    end

    it 'should return json' do
      expect(json).to_not be_nil
      expect(json).to be_a(Hash)
    end

    it 'should return errors' do
      expect(json['errors']).to_not be_nil
      expect(json['errors']).to be_a(Array)
      expect(json['errors'].size).to eq(1)
    end

    it 'should return error "Password_confirmation can\'t be blank"' do
      expect(json['errors']).to eq(['Password_confirmation can\'t be blank'])
    end

    it 'should return 400 Bad Request' do
      expect(response).to have_http_status(400)
    end
  end

  describe 'POST /users: short password' do
    before do
      password = Faker::Internet.password(max_length: 5, min_length: 5)
      post '/users', params: {
        login: Faker::Internet.username,
        name: Faker::Lorem.word,
        password: password,
        password_confirmation: password
      }
    end

    it 'should return json' do
      expect(json).to_not be_nil
      expect(json).to be_a(Hash)
    end

    it 'should return errors' do
      expect(json['errors']).to_not be_nil
      expect(json['errors']).to be_a(Array)
      expect(json['errors'].size).to eq(1)
    end

    it 'should return error "Password is too short (minimum is 6 characters)' do
      expect(json['errors']).to eq(['Password is too short (minimum is 6 characters)'])
    end

    it 'should return 400 Bad Request' do
      expect(response).to have_http_status(400)
    end
  end

  describe 'POST /users: different passwords in confirmationn' do
    before do
      post '/users', params: {
        login: Faker::Internet.username,
        name: Faker::Lorem.word,
        password: Faker::Internet.password(min_length: 6),
        password_confirmation: Faker::Internet.password(min_length: 6)
      }
    end

    it 'should return json' do
      expect(json).to_not be_nil
      expect(json).to be_a(Hash)
    end

    it 'should return errors' do
      expect(json['errors']).to_not be_nil
      expect(json['errors']).to be_a(Array)
      expect(json['errors'].size).to eq(1)
    end

    it 'should return error "Password confirmation doesn\'t match Password"' do
      expect(json['errors']).to eq(['Password confirmation doesn\'t match Password'])
    end

    it 'should return 400 Bad Request' do
      expect(response).to have_http_status(400)
    end
  end

  describe 'POST /users: testing unique login' do
    password = Faker::Internet.password(min_length: 6)
    before do
      post '/users', params: {
        login: users.first.login,
        name: Faker::Lorem.word,
        password: password,
        password_confirmation: password
      }
    end

    it 'should return json' do
      expect(json).to_not be_nil
      expect(json).to be_a(Hash)
    end

    it 'should return errors' do
      expect(json['errors']).to_not be_nil
      expect(json['errors']).to be_a(Array)
      expect(json['errors'].size).to eq(1)
    end

    it 'should return error "Password confirmation doesn\'t match Password"' do
      expect(json['errors']).to eq(['Login has already been taken'])
    end

    it 'should return 400 Bad Request' do
      expect(response).to have_http_status(400)
    end
  end

  describe 'POST /users: successful' do
    password = Faker::Internet.password(min_length: 6)
    login = Faker::Internet.username
    name = Faker::Lorem.word

    before do
      post '/users', params: {
        login: login,
        name: name,
        password: password,
        password_confirmation: password
      }
    end

    context 'creating user' do
      it 'should return json' do
        expect(json).to_not be_nil
        expect(json).to be_a(Hash)
      end

      it 'should not return errors' do
        expect(json['errors']).to be_nil
      end

      it 'should return created user' do
        expect(json['login']).to eq(login)
        expect(json['name']).to eq(name)
      end

      it 'should return 201 CREATED' do
        expect(response).to have_http_status(201)
      end
    end

    context 'authenticate user' do
      it 'should be able to login' do
        post '/auth/login', params: { login: login, password: password }
        expect(response).to have_http_status(200)
      end
    end
  end
end