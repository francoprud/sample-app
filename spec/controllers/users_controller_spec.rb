require 'rails_helper'

describe UsersController do
  describe 'GET #new' do
    before(:each) { get :new }

    it 'returns success status' do
      expect(response).to have_http_status :ok
    end
  end

  describe 'POST #create' do
    context 'When creating a valid user' do
      before(:each) do
        post :create, user: {
          name: 'Example Test',
          email: 'mail@valid.com',
          password: 'password',
          password_confirmation: 'password'
        }
      end


      it 'creates a new User' do
        expect(User.count).to eq 1
      end

      it 'stores the user_id in the session' do
        expect(session[:user_id].present?).to be true
      end
    end

    context 'When creating an invalid user' do
      before(:each) do
        post :create, user: {
          name: 'Example Test',
          email: 'mail@invalid',
          password: '12',
          password_confirmation: 'ab'
        }
      end

      it 'do not create a new user' do
        expect(User.count).to eq 0
      end

      it 'do not stores the user_id in the session' do
        expect(session[:user_id].present?).to be false
      end
    end
  end
end
