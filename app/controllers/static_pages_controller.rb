class StaticPagesController < ApplicationController
  PER_PAGE = 15

  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: PER_PAGE)
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
