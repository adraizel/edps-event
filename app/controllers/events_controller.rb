class EventsController < ApplicationController
  before_action ->{
    require_login(user_path)
  }, except: [:index, :show, :join]

  def index
    @event_list = Event.all() unless params[:circle].present?
    @event_list = Event.where(official: true) if params[:circle] == 'true'
    @event_list = Event.where(official: false) if params[:circle] == 'false'
  end

  def show
    @event_detail = Event.find(params[:id])
    if @event_detail.markdown?
      convert = Qiita::Markdown::Processor.new
      @event_description_md = convert.call(@event_detail.description)
      @event_description_md = @event_description_md[:output].to_s
    end
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
    begin
      raise RequireUserLogin unless current_user
      join_event = Event.find(params[:id])
      authorize! join_event
      user_event = UserEvent.new(user: current_user, event: join_event, remark: params[:remark])
      if user_event.save
        InfomationMailer.joined_email(current_user, join_event).deliver
        redirect_to joined_events_path, success: "イベントに参加しました"
      else
        redirect_to joined_events_path, warning: "すでに参加しているイベントです"
      end
    rescue Banken::NotAuthorizedError => e
      redirect_to event_path, danger: "このイベントの参加受付は終了しています"
      return
    rescue RequireUserLogin => e
      require_login(event_path(params[:id]))
    end
  end

  def unjoin
    begin
      require_login(event_path(params[:id]))
      unjoin_event = Event.find(params[:id])
      authorize! unjoin_event
    rescue Banken::NotAuthorizedError => e
      redirect_to event_path, danger: "このイベントの参加取り消し受付は終了しています"
      return
    end
    @destroy_join = UserEvent.find_by(user: current_user, event: unjoin_event)
    if @destroy_join.destroy
      InfomationMailer.unjoined_email(current_user, unjoin_event).deliver
      redirect_to joined_events_path, success: "参加を取り消しました"
    else
      redirect_to joined_events_path, warning: "参加の取り消しに失敗しました"
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
    @participated_users = @event_detail.participated_user.order(grade: :desc, student_number: :asc)
    # @participated_users_remark = {}
    # @event_detail.user_events.map{ |r| @participated_users_remark[r.user_id] = r.remark }
    @participated_users_remark = @event_detail.user_events.map{|r| [r.user_id,r.remark]}.to_h
    if @event_detail.markdown?
      convert = Qiita::Markdown::Processor.new
      @event_description_md = convert.call(@event_detail.description)
      @event_description_md = @event_description_md[:output].to_s
    end
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

  private
  def event_params
    params.require(:event).permit(:title, :description, :markdown, :charge, :roll_call_point, :location, :roll_call_time, :start_time, :end_time, :join_limit)
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
    send_data(csv_date,filename: "#{@event_detail.title}_#{I18n.l(Date.today, format: '%Y-%m-%d')}.csv")
  end
end
