require 'rails_helper'

describe 'static_pages/about.html.erb' do
  before(:each) { render template: 'static_pages/about.html.erb', layout: 'layouts/application' }

  it 'displays the page head title correctly' do
    assert_select 'title', full_title('About')
  end
end
