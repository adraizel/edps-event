class EventsLoyalty < ApplicationLoyalty
  def edit?
    record.owner == user
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

  def join?
    record.join_limit > Date.today
  end

  def unjoin?
    join?
  end
end
