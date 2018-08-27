class ActivationMailer < ApplicationMailer
  def activation_needed_email(user)
    @user = user
    @url = ENV['SITE_URL'] || 'http://localhost:3000'
    @url = @url + '/user/activate?token=' + user.activation_token
    mail(:to => user.email,
         :subject => "Edeventにようこそ")
  end
   
  def activation_success_email(user)
    @user = user
    @url = ENV['SITE_URL'] || 'http://localhost:3000'
    @url = @url + '/login'
    mail(:to => user.email,
         :subject => "アカウント認証が完了しました")
  end
end
