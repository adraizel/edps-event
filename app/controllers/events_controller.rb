class EventsController < ApplicationController
  def index
    @event_list = Event.all()
  end

  def show
    @event_detail = Event.find(params[:id])
  end

  def new
    @event = Event.new()
  end

  def create
    @new_event = current_user.events.build(event_params)
    if @new_event.save!
      EventJoin.create(user: current_user, event: @new_evemt)
      redirect_to detail_user_event_path(@new_event)
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
      redirect_to detail_user_event_path(@event), success: "情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @destroy_event = Event.find(params[:id])
    if @destroy_event.destroy!
      redirect_to held_user_events_path, success: "イベントを削除しました"
    else
      render detail_user_event_path(@destroy_event), error: "削除に失敗しました"
    end
  end

  def join
    EventJoin.create(user: current_user, event: Event.find(params[:id]))
    redirect_to joined_events_path
  end

  def unjoin
    @destroy_join = EventJoin.find_by(user: current_user, event: Event.find(params[:id]))
    if @destroy_join.destroy!
      redirect_to joined_events_path, success: "参加を取り消しました"
    else

    end
  end

  def joined
    @joined_list = current_user.event_joins
  end

  def held
    @held_list = current_user.events
  end

  def detail
    @event_detail = Event.find(params[:id])
    @joined_list = @event_detail.event_joins
  end

  private
  def event_params
    params.require(:event).permit(:title, :description, :charge, :roll_call_point, :location, :roll_call_time, :start_time, :end_time, :join_limit)
  end
end
