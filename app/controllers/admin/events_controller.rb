class Admin::EventsController < Admin::Base
  def index
    @event_list = Event.all
  end

  def show
    @event_detail = Event.find(params[:id])
    @user_events = @event_detail.user_events.includes(:user)
  end

  def new
    @new_event = Event.new()
  end

  def create
    @new_event = current_user.events.build(admin_event_params)
    @new_event.official = true;
    if @new_event.save
      redirect_to admin_event_path(@new_event), success: "イベントを登録しました"
    else
      render :new
    end
  end

  def edit
    @edit_event = Event.find(params[:id])
  end

  def update
    @edit_event = Event.find(params[:id])
    @edit_event.assign_attributes(admin_event_params)
    if @edit_event.save
      redirect_to admin_event_path(@edit_event), success: "情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @destroy_event = Event.find(params[:id])
    if @destroy_event.destroy
      redirect_to admin_events_path, success: "イベントを削除しました"
    else
    end
  end

  private
  def admin_event_params
    params.require(:event).permit(:title, :description, :charge, :roll_call_point, :location, :roll_call_time, :start_time, :end_time, :join_limit)
  end
end
