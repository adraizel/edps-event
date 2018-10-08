class Admin::MailsenderController < Admin::Base
  def index
    @event_list = Event.all
  end

  def create
    @target = params[:mail_target].to_i
    @event_list = Event.all
  end

  def check
    @event_title = Event.find(mail_params[:ml_target])
    @ml_title = mail_params[:ml_title]
    @ml_content = mail_params[:ml_content]
  end

  def mailsend
    params = mail_params
    target_users = nil
    if params[:ml_target].present?
      target_users = Event.find(params[:ml_target]).participated_user
    elsif params[:ml_targets].present?
      target_users = []
      params[:ml_targets].map{|u| target_users << User.where(grade: u.to_i)}
      target_users.flatten!
    end
    
    # binding.pry
    
    target_users.each do |u|
      InfomationMailer.infomation_email(u.email, mail_params[:ml_title], mail_params[:ml_content]).deliver
    end
    redirect_to admin_root_path, info: 'メール送信が完了しました'
  end

  def result
  end

  private
  def mail_params
    params.permit(:ml_target, :ml_title, :ml_content, ml_targets: [])
  end
end
