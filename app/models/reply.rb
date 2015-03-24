class Reply
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body
  field :body_html
  field :source
  field :message_id

  belongs_to :user, inverse_of: :replies
  belongs_to :topic, inverse_of: :replies, touch: true
  has_many :notifications, class_name: 'Notification::Base', dependent: :delete

  index user_id: 1
  index topic_id: 1

  validates :body, presence: true
  validates :body, uniqueness: true, scope: [:topic_id, :user_id], message: ""

  def self.per_page
    25
  end
  
end
