class Admin::UsersController < Admin::Base
  def index
    pibot = Date.today.month <= 3 ? Date.today.year - 1 : Date.today.year
    # d = [0, -1, -2, -3, -4].map!{|r| r + pibot}

    if params[:grade].present? && 1 <= params[:grade].to_i && params[:grade].to_i <= 5
      @user_list = User.where(grade: params[:grade].to_i).page(params[:page]).order(student_number: :asc)
    else
      @user_list = User.all.page(params[:page]).order(grade: :desc, student_number: :asc)
    end
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
    if @destroy_user.executive? == false && @destroy_user.destroy
      redirect_to :admin_root, info: "会員情報を削除しました"
    else
      flash.now[:danger] = "幹部扱いのユーザーは削除できません"
      redirect_to admin_user_path(@destroy_user)
    end
  end

  private
  def user_param
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :student_number, :grade, :birthday, :allergy_data, :remark, :executive, :mailer)
  end
end
