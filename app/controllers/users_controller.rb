class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "登録が完了しました。"
      redirect_to @user
    else
      flash[:danger] = "登録が失敗しました"
      render 'new'
    end
  end
    
    private
    
    def user_params
    params.require(:user).permit(:name, :email, :unique_name,
                                 :password, :password_confirmation)
    end
end