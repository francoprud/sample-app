require 'rails_helper'

describe MicropostsController do
  describe 'POST #create' do
    context 'When user is not logged in' do
      before(:each) do
        post :create, micropost: { content: 'Valid content' }
      end

      it 'redirects to login path' do
        expect(response).to redirect_to login_path
      end

      it 'do not create a new micropost' do
        expect(Micropost.count).to eq 0
      end
    end

    context 'When user is logged in' do
      let!(:user) { FactoryGirl.create(:user) }

      before(:each) do
        log_in_as user
        post :create, micropost: { content: 'Valid content' }
      end

      it 'creates a new micropost' do
        expect(Micropost.count).to eq 1
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user)      { FactoryGirl.create(:user) }
    let!(:micropost) { FactoryGirl.create(:micropost, user: user) }

    context 'When user is not logged in' do
      before(:each) do
        delete :destroy, id: micropost
      end

      it 'redirects to login path' do
        expect(response).to redirect_to login_path
      end

      it 'do not destroy the micropost' do
        expect(Micropost.count).to eq 1
      end
    end

    context 'When user is logged in' do
      before(:each) { log_in_as user }

      context 'and trying to delete one of his microposts' do
        it 'reduces by one the amount of microposts' do
          delete :destroy, id: micropost
          expect(Micropost.count).to eq 0
        end
      end

      context 'and trying to delete a micropost that do not belong to him' do
        let!(:not_logged_in_user) { FactoryGirl.create(:user) }
        let!(:other_micropost)    { FactoryGirl.create(:micropost, user: not_logged_in_user) }

        before(:each) { delete :destroy, id: other_micropost }

        it 'redirects to root path' do
          expect(response).to redirect_to root_path
        end

        it 'do not destroy the micropost' do
          expect(Micropost.count).to eq 2
        end
      end
    end
  end
end
