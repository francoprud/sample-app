class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if valid_user user
      user.activate
      log_in user
      display_flash(:success, 'Account activated!')
      redirect_to user
    else
      display_flash(:danger, 'Invalid activation link')
      redirect_to root_url
    end
  end

  private

  def valid_user(user)
    user && !user.activated? && user.authenticated?(:activation, params[:id])
  end
end
