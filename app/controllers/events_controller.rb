class EventsController < ApplicationController
  def index
    @event_list = Event.all()
  end

  def show
  end

  def new
    @event = Event.new()
  end

  def create
    if current_user.events.create(event_params)
      redirect_to events_path(@event)
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.assign_attributes(event_params)
    if @event.save!
      redirect_to events_path(@event), success: "情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
  end

  def join
  end

  def unjoin
  end

  def joined
    @joined_list = current_user.event_joins
  end

  def hold
    @hold_list = current_user.events
  end

  private
  def event_params
    params.require(:event).permit(:title, :description, :charge, :roll_call_point, :location, :roll_call_time, :start_time, :end_time, :join_limit)
  end
end
