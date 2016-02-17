require 'rails_helper'

describe PasswordResetsController do
  describe 'GET #new' do
    before(:each) { get :new }

    it 'returns success status' do
      expect(response).to have_http_status :ok
    end

    it 'renders new template' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'When user exists' do
      let!(:user) { FactoryGirl.create(:user) }

      before(:each) do
        ActionMailer::Base.deliveries.clear # Clear the array of delivers
        post :create, email: user.email
      end

      it 'sets the reset_digest field to user' do
        expect(User.first.reset_digest.present?).to be true
      end

      it 'sets the reset_sent at field to user' do
        expect(User.first.reset_sent_at.present?).to be true
      end

      it 'sends mail to user' do
        expect(ActionMailer::Base.deliveries.count).to eq 1
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'When usr do no exist' do
      before(:each) do
        ActionMailer::Base.deliveries.clear # Clear the array of delivers
        post :create, email: 'invalid@email.com'
      end

      it 'do not sends any email' do
        expect(ActionMailer::Base.deliveries.count).to eq 0
      end

      it 'returns success status' do
        expect(response).to have_http_status :ok
      end

      it 'renders new template' do
        expect(response).to render_template :new
      end
    end
  end

  describe '#GET edit' do
    context 'When user exists' do
      let!(:reset_token) { 'valid_token' }

      context 'and it is a valid user' do
        context 'and token is not expired' do
          let!(:not_expired_time) { Time.zone.now }
          let!(:user) do
            FactoryGirl.create(:user, reset_digest:  User.digest(reset_token),
                                      reset_sent_at: not_expired_time)
          end

          before(:each) { get :edit, id: reset_token, email: user.email }

          it 'returns success status' do
            expect(response).to have_http_status :ok
          end

          it 'renders edit template' do
            expect(response).to render_template :edit
          end
        end

        context 'and token has expired' do
          let!(:expired_time) { Time.zone.now - 3.hours }
          let!(:user) do
            FactoryGirl.create(:user, reset_digest:  User.digest(reset_token),
                                      reset_sent_at: expired_time)
          end

          before(:each) { get :edit, id: reset_token, email: user.email }

          it 'redirects to new password reset path' do
            expect(response).to redirect_to new_password_reset_path
          end
        end
      end

      context 'and the user is not activated' do
        let!(:user) { FactoryGirl.create(:user, activated: false) }

        before(:each) { get :edit, id: reset_token, email: user.email }

        it 'redirects to root path' do
          expect(response).to redirect_to root_path
        end
      end
    end

    context 'When user do not exist' do
      it 'redirects to root path' do
        get :edit, id: 'reset_token', email: 'invalid@email.com'
        expect(response).to redirect_to root_path
      end
    end
  end

  describe '#PATCH update' do
    context 'When updating the user correctly' do
      let!(:reset_token) { 'valid_token' }
      let!(:user) do
        FactoryGirl.create(:user, reset_digest:  User.digest(reset_token),
                                  reset_sent_at: Time.zone.now)
      end

      before(:each) do
        post :update, id: reset_token,
                      email: user.email,
                      user: {
                        password: '123123123',
                        password_confirmation: '123123123'
                      }
      end

      it 'redirects to profile view' do
        expect(response).to redirect_to user
      end
    end
  end
end
