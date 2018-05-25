class ApplicationController < ActionController::Base
  include Banken
  protect_from_forgery with: :exception

  def set_back_url(url)
    session[:return_to_url] = url
  end
end
