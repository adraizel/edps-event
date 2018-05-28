class Admin::EventsLoyalty < ApplicationLoyalty
  def index?
    user.executive?
  end

  def show?
    user.executive?
  end

  def new?
    user.executive?
  end

  def create?
    user.executive?
  end

  def edit?
    user.executive?
  end

  def update?
    user.executive?
  end

  def destroy?
    user.executive?
  end
end
