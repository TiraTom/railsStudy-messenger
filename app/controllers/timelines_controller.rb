class TimelinesController < ApplicationController
  def index
    @input_message = Timeline.new
    @timeline = Timeline.includes(:user).order('updated_at DESC')
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
  
  private 
  def timeline_params
    params.require(:timeline).permit(:message)
  end  
      
end
