require 'rails_helper'

describe UsersController do
  describe 'GET #new' do
    before(:each) { get :new }

    it 'returns success status' do
      expect(response).to have_http_status :ok
    end
  end
end
