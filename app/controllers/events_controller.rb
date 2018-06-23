class EventsController < ApplicationController
  before_action ->{
    require_login(user_path)
  }, except: [:index, :show, :join]

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
    @new_event = current_user.held_events.build(event_params)
    if @new_event.save
      UserEvent.create(user: current_user, event: @new_evemt)
      redirect_to detail_user_event_path(@new_event)
    else
      render :new
    end
  end

  def edit
    @edit_event = Event.find(params[:id])
    authorize! @edit_event
  end

  def update
    @edit_event = Event.find(params[:id])
    authorize! @edit_event
    @edit_event.assign_attributes(event_params)
    if @edit_event.save
      redirect_to detail_user_event_path(@edit_event), success: "情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @destroy_event = Event.find(params[:id])
    authorize! @destroy_event
    if @destroy_event.destroy
      redirect_to held_user_events_path, success: "イベントを削除しました"
    else
      render detail_user_event_path(@destroy_event), danger: "削除に失敗しました"
    end
  end

  def join
    require_login(event_path(params[:id]))
    @user_event = UserEvent.new(user: current_user, event: Event.find(params[:id]), remark: params[:remark])
    if @user_event.save
      redirect_to joined_events_path, success: "イベントに参加しました"
    else

    end
  end

  def unjoin
    @destroy_join = UserEvent.find_by(user: current_user, event: Event.find(params[:id]))
    if @destroy_join.destroy
      redirect_to joined_events_path, success: "参加を取り消しました"
    else

    end
  end

  def joined
    @joined_list = current_user.joined_events
  end

  def held
    @held_list = current_user.held_events
  end

  def detail
    @event_detail = Event.find(params[:id])
    authorize! @event_detail
    @participated_users = @event_detail.participated_user.order(entrance_year: :desc, student_number: :asc)
    @participated_users_remark = {}
    @event_detail.user_events.map{ |r| @participated_users_remark[r.user_id] = r.remark }
  end

  private
  def event_params
    params.require(:event).permit(:title, :description, :charge, :roll_call_point, :location, :roll_call_time, :start_time, :end_time, :join_limit)
  end
end
