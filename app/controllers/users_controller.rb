class UsersController < ApplicationController
 before_action :logged_in_user, only: [:edit, :update, :destroy]
 before_action :set_user, only: [:show, :edit, :update]
 before_action :correct_user,   only: [:edit, :update]
 before_action :admin_user,     only: :destroy

  def index 
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @posts = @user.posts.paginate(page: params[:page], :per_page => 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "登録したメールアドレスにメールを送信しました。ご確認下さい！"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to users_url
  end


  private

   def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
   end

   def set_user
       @user = User.find(params[:id])
   end


  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
      redirect_to(root_url) unless current_user.admin?
  end
end
