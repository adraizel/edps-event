class Admin::PagesController < ApplicationController
  layout 'admin'
  
  def index
    authorize!
  end
end
