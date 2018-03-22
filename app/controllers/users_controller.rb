class UsersController < ApplicationController
  def show
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
      redirect_to :root, success: "情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
  end

  private
  def user_param
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :student_number, :birthday, :allergy_data, :remark)
  end
end
