class PagesController < ApplicationController
  def index
    @lately_events = Event.available_events.limit(3)
  end
end
