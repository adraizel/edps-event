class ApplicationController < ActionController::Base
  include Banken
  protect_from_forgery with: :exception

  class NotFound < StandardError; end
  class Forbidden < StandardError; end
  class RequireUserLogin < StandardError; end
  class RequireExecutivePermission < StandardError; end

  def set_back_url(url)
    session[:return_to_url] = url
  end

  def require_login(url = nil)
    unless current_user
      set_back_url(url) if url.present?
      redirect_to login_path
    end
  end

  add_flash_types :primary, :link, :info, :success, :warning, :danger
end
