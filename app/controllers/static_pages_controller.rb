class StaticPagesController < ApplicationController
  PER_PAGE = 15

  def home
    return unless logged_in?
    @micropost  = current_user.microposts.build
    @feed_items = current_user.feed.paginate(page: params[:page], per_page: PER_PAGE)
  end

  def help
  end

  def about
  end

  def contact
  end
end
