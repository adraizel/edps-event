class ActivationMailer < ApplicationMailer
  def activation_needed_email(user)
    @user = user
    @url = "http://0.0.0.0:3000/users/activate?token=#{user.activation_token}"
    @url = ENV['SITE_URL'] + "/user/activate?=" user.activation_token if ENV['SITE_URL'].present?
    mail(:to => user.email,
         :subject => "Edeventにようこそ")
  end
   
  def activation_success_email(user)
    @user = user
    @url  = "http://0.0.0.0:3000/login"
    @url = ENV['SITE_URL'] + "/login" if ENV['SITE_URL'].present?
    mail(:to => user.email,
         :subject => "アカウント認証が完了しました")
  end
end
