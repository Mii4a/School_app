class StaticPagesController < ApplicationController
  def home
    @school = current_user.schools.build if logged_in?
  end

  def help
  end
  
  def about
  end
end
