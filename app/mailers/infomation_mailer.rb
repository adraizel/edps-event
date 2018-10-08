class InfomationMailer < ApplicationMailer
  def joined_email(user, event)
    @event = event
    mail(to: user.email,
          subject: "Edevent - イベント参加確認")
  end

  def unjoined_email(user, event)
    @event = event
    mail(to: user.email,
          subject: "Edevent - イベント参加取り消し確認")
  end

  def infomation_email(mailaddress, subject, content)
    @content = content
    mail(:to => mailaddress,
         :subject => subject)
  end
end
