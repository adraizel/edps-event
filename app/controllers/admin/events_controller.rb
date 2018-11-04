class Admin::EventsController < Admin::Base
  def index
    @event_list = Event.available_events
    @event_list = @event_list.circle_events if params[:circle] == 'true'
    @event_list = @event_list.member_events if params[:circle] == 'false'
    @event_list = @event_list.page(params[:page])
  end

  def show
    @event = Event.find(params[:id])
    @participated_users = @event.participated_user.order(grade: :desc, student_number: :asc)
    @participated_users_remark = @event.user_events.map { |r| [r.user_id, r.remark] }.to_h
    respond_to do |format|
      format.html
      format.csv do
        if params[:sjis]
          participated_users_csv(Encoding::Shift_JIS)
        else
          participated_users_csv
        end
        return
      end
    end
  end

  def new
    @new_event = Event.new
  end

  def create
    @new_event = current_user.held_events.build(admin_event_params)
    @new_event.official = true
    if @new_event.save
      redirect_to admin_event_path(@new_event), success: 'イベントを登録しました'
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
      redirect_to admin_event_path(@edit_event), success: '情報を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @destroy_event = Event.find(params[:id])
    @destroy_event.deleted = true
    if @destroy_event.save
      redirect_to admin_events_path, success: 'イベントを削除しました'
    else
      redirect_to admin_event_path(@destroy_event), warning: 'イベントを削除出来ませんでした'
    end
  end

  private
  def admin_event_params
    params.require(:event).permit(:title, :summary, :description, :converted_description, :start_time, :join_limit, :owner_id, :official, :deleted)
  end

  def participated_users_csv(encode = Encoding::UTF_8)
    require 'csv'
    csv_date = CSV.generate(encoding: encode) do |csv|
      csv_column_names = ['学籍番号', '氏名', 'アレルギー情報', '成人', '備考']
      csv << csv_column_names
      @participated_users.each do |l|
        csv_column_values = [
          l.student_number,
          l.name,
          l.allergy_data,
          l.adult? ? '○' : '×',
          @participated_users_remark[l.id]
        ]
        csv << csv_column_values
      end
    end
    send_data(csv_date,filename: "#{@event.title}_#{I18n.l(Date.today, format: '%Y-%m-%d')}.csv")
  end
end
