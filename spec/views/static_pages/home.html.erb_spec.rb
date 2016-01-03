require 'rails_helper'

describe 'static_pages/home.html.erb' do
  before(:each) { render template: 'static_pages/home.html.erb', layout: 'layouts/application' }

  it 'displays the page head title correctly' do
    assert_select "title", "Home | Ruby on Rails Tutorial Sample App"
  end
end
