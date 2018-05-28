class ApplicationController < ActionController::Base
  include Banken
  protect_from_forgery with: :exception

  def set_back_url(url)
    session[:return_to_url] = url
  end

  def require_login(url)
    unless current_user
      set_back_url(url) if url.present?
      redirect_to login_path
    end
  end
end
