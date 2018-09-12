class InfomationMailer < ApplicationMailer
  def infomation_email(mailaddress, subject, content)
    @content = content
    mail(:to => mailaddress,
         :subject => subject)
  end
end
