class SessionsController < ApplicationController
  before_action :not_logged_in_user, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      if user.activated?
        log_in user
        params[:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        flash[:warning] = 'Account not activated. Check your email for the activation link.'
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  # Confirms a not logged-in user
  def not_logged_in_user
    return unless logged_in?
    flash[:danger] = 'You are already logged in'
    redirect_to root_url
  end
end
