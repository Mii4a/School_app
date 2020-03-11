class SchoolsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  def create
    @school = current_user.schools.build(school_params)
    if @school.save
      flash[:success] = "新しい学校を設立しました！"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end
  
  def destroy
  end
  
  private
  
  def school_params
    params.require(:school).permit(:sub_title,
                                   :name,
                                   :content)
  end   
end
