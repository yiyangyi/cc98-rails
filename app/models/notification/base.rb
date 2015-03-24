class Notification::Base
  include Mongoid::Document
  include Mongoid::Timestamps

  field :read, default: false

  belongs_to :user

  index :read
  index user_id: 1, read: 1

  scope :unread, -> { where(read: false) }

  def push_to_client_realtime
  	if self.user
      hash = self.notice_hash
  	  hash[:count] = self.user.notification.unread.count
  	  FayeClient.send("/notifications_count/#{self.user.access_token}", hash)
  	end
  end

  def anchor
  	"notification-#{id}"
  end

  def content_path
    ''
  end

end