class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy, 
                                        :schools, :entered_schools, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @users = User.feed.page(params[:page]).per(20)
    if logged_in?
      @user = current_user
      @school_build = current_user.schools.build
    end
  end
  
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @schools = @user.myfeed.page(params[:page]).per(10)
    @school_build = current_user.schools.build if logged_in?
    redirect_to root_url and return unless @user.activated?
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "アカウント有効化のために、メールをご確認ください"
      redirect_to root_url
    else
      flash[:danger] = "登録に失敗しました。"
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    @school_build = @user.schools.build
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "更新しました"
      redirect_to @user
    else
      @school_build = @user.schools.build
      flash[:danger] = "更新に失敗しました"
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "削除しました"
    redirect_to users_url
  end
  
  def schools
    @user = User.find(params[:id])
    @schools = @user.schools.page(params[:page]).per(20)
    @school_build = @user.schools.build
  end
  
  def entered_schools
    @user = User.find(params[:id])
    @schools = @user.entered_schools.page(params[:page]).per(20)
    @school_build = @user.schools.build
  end
  
  def following
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(20)
    @school_build = @user.schools.build
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(20)
    @school_build = @user.schools.build
  end
    
    private
    
    def user_params
    params.require(:user).permit(:name, :email, :unique_name,
                                 :password, :password_confirmation)
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
end
