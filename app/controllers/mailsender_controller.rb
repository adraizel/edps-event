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
      validation_error_json_response('invalid', @mail_data.errors)
    else
      @event_title = Event.find(@mail_data.target_event).title
      html_json_response('valid', 'check_page')
    end
  end

  def mailsend
    @mail_data = MailData.new(mail_params)
    @event = Event.find(@mail_data.target_event)
    if params[:commit] == 'メールを編集する'
      @event_list = current_user.held_events.available_events
      html_json_response('re_edit', 'create_form')
    else
      @event.participated_user.each do |u|
        InfomationMailer.infomation_email(u.email, @mail_data.title, @mail_data.content).deliver
      end
      redirect_to root_path, info: 'メール送信が完了しました'
    end
  end

  private
  def set_event_params
    params.permit(:target)
  end

  def mail_params
    params.require(:mail_data).permit(:target_event, :title, :content)
  end

  def html_json_response(res, render_target)
    partial_renderd = render_to_string(partial: render_target)
    render json: { result: res, html: partial_renderd }, status: :ok
  end

  def validation_error_json_response(res, error)
    message = error.messages.map { |m| [m.first, MailData.human_attribute_name(m.first) + m.second[0]]}.to_h
    render json: { result: res, errors: message }, status: :ok
  end
end
