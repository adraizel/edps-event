class MailsenderController < ApplicationController
  def create
    @event_list = current_user.held_events
    if @event_list.length <= 0
      redirect_to user_path, warning: '開催したイベントが存在しません。'
    end
  end

  def check
    @event_title = Event.find(mail_params[:ml_target])
    @ml_title = mail_params[:ml_title]
    @ml_content = mail_params[:ml_content]
  end

  def mailsend
    @event = Event.find(mail_params[:ml_target])
    @event.participated_user.each do |u|
      InfomationMailer.infomation_email(u.email, mail_params[:ml_title], mail_params[:ml_content]).deliver
    end
    redirect_to root_path, info: 'メール送信が完了しました'
  end

  def result
  end

  private
  def mail_params
    params.permit(:ml_target, :ml_title, :ml_content)
  end
end
