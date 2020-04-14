class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @user = current_user
      @school = current_user.feed.page(params[:page]).per(10)
      @school_build = current_user.schools.build
      @feed_items = current_user.feed.page(params[:page]).per(10)
    end
  end

  def help
    if logged_in?
      @user = current_user
      @school_build = current_user.schools.build
    end
  end
  
  def about
  end
end
