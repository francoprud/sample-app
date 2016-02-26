class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]
  before_action :not_logged_in_user, only: [:new, :create]
  before_action :activated_user, only: [:show]

  PER_PAGE = 15

  def index
    @users = User.where(activated: true)
             .paginate(page: params[:page], per_page: PER_PAGE).order('name ASC')
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], per_page: PER_PAGE)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      display_flash(:info, 'Please check your email to activate your account.')
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      display_flash(:success, 'Profile updated!')
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    if (user = User.find(params[:id]))
      user.destroy
      display_flash(:success, 'User deleted')
    else
      display_flash(:danger, 'User does not exist or is invalid')
    end
    redirect_to users_url
  end

  def following
    @title = 'Following'
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page], per_page: PER_PAGE)
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], per_page: PER_PAGE)
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Confirms the correct user
  def correct_user
    user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(user)
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  # Confirms a not logged-in user
  def not_logged_in_user
    return unless logged_in?
    display_flash(:danger, 'You are already logged in')
    redirect_to root_url
  end

  # Confirms if user is already activated
  def activated_user
    user = User.find(params[:id])
    return if user && user.activated?
    display_flash(:danger, 'User is not already activated')
    redirect_to root_url
  end
end
