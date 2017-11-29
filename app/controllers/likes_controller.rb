class LikesController < ApplicationController
  helper_method :count_like
  
  def create
    like_by = current_user
    @timeline_id = like_params["timeline_id"]
    like = Like.new(user_id: like_by.id, timeline_id: @timeline_id)
    like.save!
    render json: {new_count: count_like}
  end
  
  private
  def like_params
    params.require(:like).permit(:timeline_id)
  end
end
