class Admin::Base < ApplicationController
  before_action -> {
    require_executive_login
  }
  layout 'admin'

  private
  def require_executive_login
    raise RequireExecutivePermission unless current_user.executive?
  end
end