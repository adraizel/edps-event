class SessionController < ApplicationController
  def new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to user_path, notice: "ログインしました"
    else
      flash.now[:notice] = "ログインに失敗しました"
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to :root, notice: "ログアウトしました"
  end
end
