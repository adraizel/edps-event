class EventsController < ApplicationController
  def index
    @event_list = Event.all()
  end

  def show
    @event_detail = Event.find(params[:id])
  end

  def new
    @new_event = Event.new()
  end

  def create
    @new_event = current_user.events.build(event_params)
    if @new_event.save
      EventJoin.create(user: current_user, event: @new_evemt)
      redirect_to detail_user_event_path(@new_event)
    else
      render :new
    end
  end

  def edit
    @edit_event = Event.find(params[:id])
  end

  def update
    @edit_event = Event.find(params[:id])
    @edit_event.assign_attributes(event_params)
    if @edit_event.save
      redirect_to detail_user_event_path(@event), success: "情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @destroy_event = Event.find(params[:id])
    if @destroy_event.destroy
      redirect_to held_user_events_path, success: "イベントを削除しました"
    else
      render detail_user_event_path(@destroy_event), error: "削除に失敗しました"
    end
  end

  def join
    @event_join = EventJoin.new(user: current_user, event: Event.find(params[:id]))
    if @event_join.save
      redirect_to joined_events_path, success: "イベントに参加しました"
    else

    end
  end

  def unjoin
    @destroy_join = EventJoin.find_by(user: current_user, event: Event.find(params[:id]))
    if @destroy_join.destroy
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
