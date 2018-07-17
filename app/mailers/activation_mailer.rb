class ActivationMailer < ApplicationMailer
  def activation_needed_email(user)
    @user = user
    @url  = "http://0.0.0.0:3000/users/activate?token=#{user.activation_token}"
    mail(:to => user.email,
         :subject => "Edeventにようこそ")
  end
   
  def activation_success_email(user)
    @user = user
    @url  = "http://0.0.0.0:3000/login"
    mail(:to => user.email,
         :subject => "アカウント認証が完了しました")
  end
end
