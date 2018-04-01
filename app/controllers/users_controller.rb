class UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
  end

  
  def new
    @user = User.new()
  end

  def create
    @user = User.new(user_param)
    if @user.save!
      redirect_to :root, success: "登録しました"
    else
      render :new
    end
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    @user.assign_attributes(user_param)
    if @user.save!
      redirect_to user_path, success: "情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @d_user = User.find(current_user.id)
    if @d_user.destroy!
      logout
      redirect_to :root, notice: "会員情報を削除しました"
    else
    end
  end

  private
  def user_param
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :student_number, :birthday, :allergy_data, :remark)
  end
end
