class UsersController < ApplicationController
  before_action ->{
    require_login(user_path)
  }, except: [:new, :create]

  def show
    @user = User.find(current_user.id)
  end

  
  def new
    @new_user = User.new()
  end

  def create
    @new_user = User.new(user_param)
    if @new_user.save
      redirect_to :root, success: "登録しました"
    else
      render :new
    end
  end

  def edit
    @edit_user = User.find(current_user.id)
  end

  def update
    @edit_user = User.find(current_user.id)
    @edit_user.assign_attributes(edit_user_param)
    if @edit_user.save
      redirect_to user_path, success: "情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @destroy_user = User.find(current_user.id)
    if @destroy_user.destroy
      logout
      redirect_to :root, notice: "会員情報を削除しました"
    else
      
    end
  end

  private
  def user_param
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :student_number, :birthday, :allergy_data, :remark)
  end

  def edit_user_param
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :allergy_data, :remark)
  end
end
