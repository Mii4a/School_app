class SchoolsController < ApplicationController
before_action :logged_in_user, only: [:create, :destroy, :edit, :update, :show]
before_action :correct_user, only: [:destroy, :edit, :update]
  
  def create
    @school_build = current_user.schools.build(school_params)
    if @school_build.save
      flash[:success] = "新しい学校を設立しました！"
      redirect_to root_url
    else
      @feed_items = []
      flash[:danger] = "学校の設立に失敗しました"
      render 'static_pages/home'
    end
  end
  
  def destroy
    @school.destroy
    flash[:success] = "削除に成功しました"
    redirect_to request.referrer || root_url
  end
  
  def edit
    @user = current_user
    @school = School.find(params[:id])
    @school_build = @user.schools.build
  end
  
  def show
    @school = School.find(params[:id])
    @school_chats = @school.school_chats.page(params[:page]).per(10)
    if logged_in?
      @school_chats_build = current_user.school_chats.build 
      @school_build = current_user.schools.build
    end
  end
  
  def update
    @school_build = current_user.schools.build
    if @school.update_attributes(school_params)
      flash[:success] = "更新しました"
      redirect_to root_url
    else
      flash[:danger] = "更新に失敗しました"
      render 'edit'
    end
  end
  
  def index
    @schools = School.all.page(params[:page]).per(20)
    if logged_in?
      @user = current_user
      @school_build = current_user.schools.build
    end
  end
  
  private
  
  def school_params
    params.require(:school).permit(:sub_title,
                                   :name,
                                   :content,
                                   :picture)
  end
  
  def correct_user
    @user = current_user
    @school = School.find(params[:id])
    redirect_to root_url  unless @user == @school.user
  end
end
