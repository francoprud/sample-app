class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  # Confirms a logged-in user
  def logged_in_user
    return if logged_in?
    store_location
    display_flash(:danger, 'Please log in.')
    redirect_to login_url
  end

  # Displays a flash message. Arguments: (symbol, string)
  def display_flash(method, message)
    flash[method] = message
  end

  def display_flash_now(method, message)
    flash.now[method] = message
  end
end
