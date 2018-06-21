class Admin::PagesController < Admin::Base
  def index
    @official_event_count = Event.where(official: true).count
    @unofficial_event_count = Event.where(official: false).count
    @user_count = User.all.count
  end
end
