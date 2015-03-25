class Reply
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Likable
  include Mongoid::CounterCache

  field :body
  field :body_html
  field :source
  field :message_id

  belongs_to :user, inverse_of: :replies
  belongs_to :topic, inverse_of: :replies, touch: true
  has_many :notifications, class_name: 'Notification::Base', dependent: :delete

  counter_cache name: :user,  inverse_of: :replies
  counter_cache name: :topic, inverse_of: :replies

  index user_id: 1
  index topic_id: 1

  validates :body, presence: true
  validates :body, uniqueness: true, scope: [:topic_id, :user_id], message: ""

  def self.per_page
    25
  end

  def self.popular?
    self.likes_count >= 5
  end

end
