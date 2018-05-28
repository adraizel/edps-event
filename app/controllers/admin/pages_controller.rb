class Admin::PagesController < ApplicationController
  before_action -> {
    require_login
  }
  layout 'admin'
  
  def index
    authorize!
  end
end
