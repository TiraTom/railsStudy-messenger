class TimelinesController < ApplicationController
  def index
    @input_message = Timeline.new
    #メッセージ入力
    @input_message = params[:id] ? Timeline.find(params[:id]) : Timeline.new
    #タイムライン取得
    @timeline = Timeline.includes(:user).not_reply.user_filter(params[:filter_user_id]).order('updated_at DESC')
    #ユーザ一覧取得
    @users = User.all
    @like = Like.new
    @like_counts = count_likes

    if params[:reply_id]
      @reply_timeline = Timeline.find(params[:reply_id])
    end
  end
  
  def create
    timeline = Timeline.new
    timeline.attributes = timeline_params
    timeline.user_id = current_user.id
    if timeline.valid?
      timeline.save!
      respond_to do |format|
        format.html do
          redirect_to action: :index
        end
        format.json do
          if @like_counts[timeline.id].nil?
            count = 0
          else
            count = @like_counts[timeline.id]
          end
          html = render_to_string partial: 'timelines/timeline', layout: false, formats: :html, locals: { timeline: timeline, like_count: count }
          render json: {timeline: html}
        end
      end
    else
      respond_to do |format|
        format.html do
          flash[:alert] = timeline.errors.full_messages
          redirect_to action: :index
        end
        format.json do
          render json: { error_message: timeline.errors.full_messages }
        end
      end
    end
  end
  
  def update
    timeline = Timeline.find(params[:id])
    timeline.attributes = timeline_params
    if timeline.valid?
      timeline.save!
    else 
      flash[:alert] = timeline.errors.full_messages
    end
    redirect_to action: :index
  end
  
  def delete
    timeline = Timeline.find(params[:id])
    timeline.destroy
    redirect_to action: :index
  end
  
  def filter_by_user
    if params[:filter_user_id].present?
      redirect_to action: :index, filter_user_id: params[:filter_user_id]
    else
      redirect_to action: :index
    end
  end
  
  private 
  def timeline_params
    params.require(:timeline).permit(:message, :reply_id)
  end  
  
end
