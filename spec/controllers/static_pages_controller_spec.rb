require 'rails_helper'

describe StaticPagesController do
  describe 'GET #home' do
    before(:each) { get :home }

    it 'returns success status' do
      expect(response).to have_http_status :ok
    end
  end

  describe 'GET #help' do
    before(:each) { get :help }

    it 'returns success status' do
      expect(response).to have_http_status :ok
    end
  end

  describe 'GET #about' do
    before(:each) { get :about }

    it 'returns success status' do
      expect(response).to have_http_status :ok
    end
  end

  describe 'GET #contact' do
    before(:each) { get :contact }

    it 'returns success status' do
      expect(response).to have_http_status :ok
    end
  end
end
