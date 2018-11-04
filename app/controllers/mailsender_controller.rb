class MailsenderController < ApplicationController
  def create
    @mail_data = MailData.new(set_event_params)
    @event_list = current_user.held_events.available_events
    if @event_list.length <= 0
      redirect_to user_path, warning: '開催したイベントが存在しません。'
    end
  end

  def check
    @mail_data = MailData.new(mail_params)
    if @mail_data.invalid?
      @event_list = current_user.held_events.available_events
      
      render :create unless @mail_data.valid?
    end
    @event_title = Event.find(@mail_data.target).title
  end

  def mailsend
    @mail_data = MailData.new(mail_params)
    @event = Event.find(@mail_data.target)
    @event.participated_user.each do |u|
      InfomationMailer.infomation_email(u.email, @mail_data.title, @mail_data.content).deliver
    end
    redirect_to root_path, info: 'メール送信が完了しました'
  end

  private
  def set_event_params
    params.permit(:target)
  end

  def mail_params
    params.require(:mail_data).permit(:target, :title, :content)
  end
end
