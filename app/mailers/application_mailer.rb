class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  default from: ENV['EMAIL_SEND_FROM'] if ENV['EMAIL_SEND_FROM'].present?
  layout 'mailer'
end
