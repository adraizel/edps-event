class UsersController < ApplicationController
  def show
  end

  def new
    @user = User.new()
  end

  def create
    @user = User.new(new_user_param)
    if @user.save!
      redirect_to :root, success: "登録しました"
    else
      render :new
    end
  end

  def edit
    @user = User.find(current_user)
  end

  def update
  end

  def destroy
  end

  private
  def new_user_param
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :student_number, :birthday, :allergy_data, :remark)
  end

  def edit_user_param
  end
end
