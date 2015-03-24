class Notification::Base
  include Mongoid::Document
  include Mongoid::Timestamps

  field :read, default: false

  belongs_to :user

  index :read
  index user_id: 1, read: 1

  scope :unread, -> { where(read: false) }
  
end