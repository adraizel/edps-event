class EventsLoyalty < ApplicationLoyalty
  def edit?
    record.user == user
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  def detail?
    edit?
  end
end
