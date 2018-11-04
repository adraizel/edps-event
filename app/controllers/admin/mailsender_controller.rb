class Admin::MailsenderController < Admin::Base
  def index
  end

  def create
    @mail_data = MailData.new(set_event_params)
    @event_list = Event.available_events
  end

  def check
    @mail_data = MailData.new(mail_params)
    if @mail_data.invalid?
      @event_list = Event.available_events
      render :create unless @mail_data.valid?
    end
    @event_title = Event.find(@mail_data.target).title unless @mail_data.target == '-1'
    @target_grade = @mail_data.targets.map { |m| m != '5' ? "#{m}年" : '卒業生' }.join(' ') if @mail_data.targets.present?
  end

  def mailsend
    @mail_data = MailData.new(mail_params)
    @mail_data.targets = @mail_data.targets.split(' ').map(&:to_i)
    target_users = create_user_list(@mail_data.target, @mail_data.targets)
    target_users.each do |u|
      InfomationMailer.infomation_email(u.email, @mail_data.title, @mail_data.content).deliver
    end
    redirect_to admin_root_path, info: 'メール送信が完了しました'
  end

  private
  def set_event_params
    params.permit(:target)
  end

  def mail_params
    params.require(:mail_data).permit(:target, :targets, :title, :content, targets: [])
  end

  def create_user_list(event_id, grade)
    list = User.all if event_id == '-1'
    list = Event.find(event_id).participated_user unless event_id == '-1'
    return grade.map { |m| list.where(grade: m) }.flatten if grade.present?
    return list
  end
end
