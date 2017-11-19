class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :authenticate_user!
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  private 
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :thumbnail, :agreement])
  end
  
  #すべてのいいねのカウントをする
  def count_likes
    likes = Like.all
    likes.group('timeline_id').count
  end
  #１つの投稿へのいいねのカウントをする
  def count_like
    count = Like.where(timeline_id: @timeline_id).count
    if count.nil?
      return 0
    else
      return count
    end
  end
  

end
