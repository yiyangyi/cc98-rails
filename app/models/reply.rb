class Reply
  include Mongoid::Document

  field :body
  field :body_html
  field :source
  field :message_id

  belongs_to :user, inverse_of: :replies
  belongs_to :topic, inverse_of: :replies, touch: true
  has_many :notifications, class_name: 'Notification::Base', dependent: :delete
end
