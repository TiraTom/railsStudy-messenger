class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :timeline
  
  validates :user_id, :uniqueness => {:scope => :timeline_id}
  
end
