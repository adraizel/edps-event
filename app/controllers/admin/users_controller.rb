class Admin::UsersController < ApplicationController
  layout 'admin'
  
  def index
    @user_list = User.all()
  end

  def show
    @user_detail = User.find(params[:id])
  end

  def new
    @new_user = User.new()
  end

  def create
    @new_user = User.new(user_param)
    if @new_user.save
      redirect_to :admin_root, success: "登録しました"
    else
      render :new
    end
  end

  def edit
    @edit_user = User.find(params[:id])
  end

  def update
    @edit_user = User.find(params[:id])
    @edit_user.assign_attributes(user_param)
    if @edit_user.save
      redirect_to admin_user_path(@edit_user), success: "情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @destroy_user = User.find(params[:id])
    if @destroy_user.destroy
      redirect_to :admin_root, notice: "会員情報を削除しました"
    else
      
    end
  end

  private
  def user_param
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :student_number, :birthday, :allergy_data, :remark)
  end
end
