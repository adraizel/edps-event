class Admin::UsersController < ApplicationController
  layout 'admin'
  
  def index
    authorize!
    @user_list = User.all()
  end

  def show
    authorize!
    @user_detail = User.find(params[:id])
  end

  def new
    authorize!
    @new_user = User.new()
  end

  def create
    authorize!
    @new_user = User.new(user_param)
    if @new_user.save
      redirect_to :admin_root, success: "登録しました"
    else
      render :new
    end
  end

  def edit
    authorize!
    @edit_user = User.find(params[:id])
  end

  def update
    authorize!
    @edit_user = User.find(params[:id])
    @edit_user.assign_attributes(user_param)
    if @edit_user.save
      redirect_to admin_user_path(@edit_user), success: "情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    authorize!
    @destroy_user = User.find(params[:id])
    if @destroy_user.executive? == false && @destroy_user.destroy
      redirect_to :admin_root, notice: "会員情報を削除しました"
    else
      flash.now[:error] = "幹部扱いのユーザーは削除できません"
      redirect_to admin_user_path(@destroy_user)
    end
  end

  private
  def user_param
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :student_number, :birthday, :allergy_data, :remark, :executive, :mailer)
  end
end
