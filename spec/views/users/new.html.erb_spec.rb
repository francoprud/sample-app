require 'rails_helper'

describe 'users/new.html.erb' do
  before(:each) { render template: 'users/new.html.erb', layout: 'layouts/application' }

  it 'displays the page head title correctly' do
    assert_select 'title', full_title('Sign up')
  end
end
