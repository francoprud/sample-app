require 'rails_helper'

describe 'static_pages/contact.html.erb' do
  before(:each) { render template: 'static_pages/contact.html.erb', layout: 'layouts/application' }

  it 'displays the page head title correctly' do
    assert_select 'title', full_title('Contact')
  end
end
