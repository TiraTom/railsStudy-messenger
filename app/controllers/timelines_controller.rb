class TimelinesController < ApplicationController
  def index
    @input_message = Timeline.new
    #メッセージ入力
    @input_message = params[:id] ? Timeline.find(params[:id]) : Timeline.new
    #タイムライン取得
    @timeline = Timeline.includes(:user).user_filter(params[:filter_user_id]).order('updated_at DESC')
    
    #ユーザ一覧取得
    @users = User.all
  end
  
  def create
    timeline = Timeline.new
    timeline.attributes = timeline_params
    timeline.user_id = current_user.id
    if timeline.valid?
      timeline.save!
    else
      flash[:alert] = timeline.errors.full_messages
    end
    redirect_to action: :index
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
  
  def filter_by_user
    if params[:filter_user_id].present?
      redirect_to action: :index, filter_user_id: params[:filter_user_id]
    else
      redirect_to action: :index
    end
  end
  
  private 
  def timeline_params
    params.require(:timeline).permit(:message)
  end  
      
end
