class UsersController < ApplicationController
  before_action ->{
    require_login(user_path)
  }, except: [:new, :create, :activate]

  def show
    @user = User.find(current_user.id)
  end

  
  def new
    @new_user = User.new()
  end

  def create
    @new_user = User.new(user_param)
    if @new_user.save
      redirect_to :root, success: "アカウント認証のメールを送信しました。メールボックスをご確認ください。"
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
      redirect_to :root, info: "会員情報を削除しました"
    else
      
    end
  end

  def activate
    if (@user = User.load_from_activation_token(params[:token]))
      @user.activate!
      redirect_to(login_path, info: 'ユーザー認証が完了しました')
    else
      not_authenticated
    end
  end

  private
  def user_param
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :student_number, :grade, :birthday, :allergy_data, :remark)
  end

  def edit_user_param
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :allergy_data, :remark)
  end
end
