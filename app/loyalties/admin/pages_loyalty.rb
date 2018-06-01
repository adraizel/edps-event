class Admin::PagesLoyalty < ApplicationLoyalty
  def index?
    user.executive?
  end
end
