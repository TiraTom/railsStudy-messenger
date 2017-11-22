module TimelinesHelper
  
  #自分の投稿か判定する
  def mypost?(timeline)
    timeline.user.id == current_user.id
  end
  
  #すでにいいねした投稿か判断する
  def already_like?(timeline)
    Like.select('user_id').where(timeline_id: timeline.id).find_by(user_id: current_user.id).present?
  end
end
