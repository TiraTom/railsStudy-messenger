class Timeline < ActiveRecord::Base
  belongs_to :user
  has_many :likes
  
  has_many :replies, class_name: 'Timeline', foreign_key: 'reply_id', dependent: :destroy
  validates :message, presence: true, allow_blank: false, length: { in: 1..150 }      
    
  scope :user_filter, -> user_id do
    where(user_id: user_id) if user_id. present?    
  end
    
  scope :not_reply, -> do
    #返信でないデータ取得
    where(reply_id: nil)
  end
  
end
