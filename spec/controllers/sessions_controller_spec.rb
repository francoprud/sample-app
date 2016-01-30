require 'rails_helper'

describe SessionsController do
  describe 'GET #new' do
    before(:each) { get :new }

    it 'returns success status' do
      expect(response).to have_http_status :ok
    end
  end

  describe 'POST #create' do
    let!(:user) { FactoryGirl.create(:user) }

    context 'When logging in with a valid user and not remembering it' do
      before(:each) do
        post :create, {
          email: user.email,
          password: user.password,
          remember_me: '0'
        }
      end

      it 'log in a user' do
        expect(logged_in?).to be true
      end

      it 'do not remembers the user' do
        expect(user.reload.remember_digest.present?).to be false
      end
    end

    context 'When logging in with a valid user and remembering it' do
      before(:each) do
        post :create, {
          email: user.email,
          password: user.password,
          remember_me: '1'
        }
      end

      it 'log in a user' do
        expect(logged_in?).to be true
      end

      it 'remembers the user' do
        expect(user.reload.remember_digest.present?).to be true
      end
    end

    context 'When logging in with an invalid user' do
      before(:each) do
        post :create, session: {
          email: user.email,
          password: 'wrong password'
        }
      end

      it 'do not log in a user' do
        expect(logged_in?).to be false
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { FactoryGirl.create(:user) }

    before(:each) do
      post :create, session: {
        email: user.email,
        password: user.password
      }
      post :destroy
    end

    context 'When logging out a user' do
      it 'log outs the current_user' do
        expect(logged_in?).to be false
      end
    end
  end
end
