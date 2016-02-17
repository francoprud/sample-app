require 'rails_helper'

describe UsersController do
  describe 'GET #new' do
    context 'When no user is logged in' do
      it 'returns success status' do
        get :new
        expect(response).to have_http_status :ok
      end
    end

    context 'When a user is logged in' do
      let!(:user) { FactoryGirl.create(:user) }

      it 'redirects to root path' do
        log_in_as user
        get :new
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET #index' do
    context 'When a user is logged in' do
      let!(:user) { FactoryGirl.create(:user) }

      it 'returns success status' do
        log_in_as(user)
        get :index
        expect(response).to have_http_status :ok
      end
    end

    context 'When no user is logged in' do
      it 'redirects to login' do
        get :index
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'POST #create' do
    context 'When no user is logged in' do
      context 'and creating a valid user' do
        before(:each) do
          ActionMailer::Base.deliveries.clear # Clear the array of delivers
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

        it 'redirects to root path' do
          expect(response).to redirect_to root_path
        end

        it 'sends an email to activate account' do
          expect(ActionMailer::Base.deliveries.count).to eq 1
        end

        it 'do not log in a user' do
          expect(logged_in?).to be false
        end
      end

      context 'and creating a user with unpermitted parameters' do
        before(:each) do
          post :create, user: {
            name: 'Example Test',
            email: 'mail@valid.com',
            password: 'password',
            password_confirmation: 'password',
            admin: true
          }
        end

        it 'do not create a new user with admin rights' do
          expect(User.first.admin?).to be false
        end
      end

      context 'and creating an invalid user' do
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

        it 'do not log in a user' do
          expect(logged_in?).to be false
        end
      end
    end

    context 'When a user is logged in' do
      let!(:user) { FactoryGirl.create(:user) }

      before(:each) do
        log_in_as user
        post :create, user: {
          name: 'Example Test',
          email: 'mail@valid.com',
          password: 'password',
          password_confirmation: 'password'
        }
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET #edit' do
    let!(:user)   { FactoryGirl.create(:user) }

    context 'When a user is logged in' do
      context 'and is his own profile' do
        it 'returns success status' do
          log_in_as(user)
          get :edit, id: user
          expect(response).to have_http_status :ok
        end
      end

      context 'but it is not his own profile' do
        let!(:other_user) { FactoryGirl.create(:user, email: 'other_user@test.com') }

        it 'redirects to root' do
          log_in_as(other_user)
          get :edit, id: user
          expect(response).to redirect_to root_path
        end
      end
    end

    context 'When no user is logged in' do
      before(:each) do
        get :edit, id: user
      end

      it 'redirects to login' do
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'PATCH #update' do
    let!(:user)   { FactoryGirl.create(:user) }
    let!(:email)  { 'update@test.com' }

    context 'When a user is logged in' do
      context 'and update params are valid' do
        before(:each) do
          log_in_as(user)
          patch :update, user: {
                          name: user.name,
                          email: email,
                          password: '',
                          password_confirmation: ''
                        }, id: user
        end

        it 'successfully updates the user' do
          expect(user.reload.email).to eq email
        end
      end
    end

    context 'When no user is logged in' do
      before(:each) do
        patch :update, user: {
                        name: user.name,
                        email: email,
                        password: '',
                        password_confirmation: ''
                      }, id: user
      end

      it 'redirects to login' do
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user_to_destroy) { FactoryGirl.create(:user) }

    context 'When a user is logged in' do
      context 'and is not an admin user' do
        let!(:user) { FactoryGirl.create(:user) }

        before(:each) do
          log_in_as user
          delete :destroy, id: user_to_destroy
        end

        it 'redirects to root' do
          expect(response).to redirect_to root_path
        end
      end

      context 'and is an admin user' do
        let!(:user) { FactoryGirl.create(:user, admin: true) }

        before(:each) do
          log_in_as user
          delete :destroy, id: user_to_destroy
        end

        it 'returns success status' do
          expect(response).to redirect_to users_path
        end

        it 'deletes the user' do
          expect(User.count).to eq 1
        end
      end
    end

    context 'When no user is logged in' do
      it 'redirects to login' do
        delete :destroy, id: user_to_destroy
        expect(response).to redirect_to login_path
      end
    end
  end

  describe '#GET show do' do
    context 'When user is activated' do
      let!(:user) { FactoryGirl.create(:user) }

      it 'returns success status' do
        get :show, id: user.id
        expect(response).to have_http_status :ok
      end
    end

    context 'When user is not activated' do
      let!(:user) { FactoryGirl.create(:user, activated: false) }

      it 'redirects to root path' do
        get :show, id: user.id
        expect(response).to redirect_to root_path
      end
    end
  end
end
