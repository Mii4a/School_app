class SchoolChatsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  
  def create
    @school_chat = current_user.school_chats.build(school_chat_params)
    @school = School.find_by(id: params[:school_chat][:school_id])
    if @school_chat.save
      flash[:success] = "投稿に成功しました!"
      redirect_to @school
    else
      @feed_items = current_user.feed.page(params[:page]).per(20)
      @school_build = current_user.schools.build
      @school_chats = []
      flash[:danger] = "1文字以上入力して下さい"
      render 'static_pages/home'
    end
  end
  
  def destroy
    SchoolChat.find(params[:id]).destroy
    flash[:success] = "削除に成功しました"
    redirect_to request.referrer || root_url
  end
  
  private
  
  def school_chat_params
    params.require(:school_chat).permit(:school_id, :content)
  end
  
  def correct_user
    redirect_to root_url unless current_user == SchoolChat.find(params[:id]).user
  end
end
