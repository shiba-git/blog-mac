class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "アカウントが認証されていません"
        message += "メールの認証リンクをクリックして下さい"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'メールアドレス/パスワードに誤りがあります。'
      render 'new'
    end
  end

  def destroy
  	log_out if logged_in?
    flash[:success] = "ログアウトしました。"
    redirect_to root_url
  end
end
