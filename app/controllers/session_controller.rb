class SessionController < ApplicationController
  def new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to user_path, info: "ログインしました"
    else
      flash.now[:danger] = "ログインに失敗しました"
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to :root, info: "ログアウトしました"
  end
end
