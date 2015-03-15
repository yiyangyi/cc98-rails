class Topic
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :body
  field :body_html
  field :last_reply_id, type: Integer
  field :replied_at, type: DateTime
  field :source
  field :message_id
  field :replies_count, type: Integer, default: 0
  field :follower_ids, type: Array, default: []
  field :suggested_at, type: DateTime
  field :last_reply_user_login
  field :node_name
  field :who_deleted
  field :last_active_mark, type: Integer
  field :lock_node, type: Mongoid::Boolean, default: false
  field :excellent, type: Integer, default: 0

  belongs_to :user, inverse_of: :topics
  belongs_to :node
  has_many :appends, dependent: :destroy
  has_many :replies, dependent: :destroy

  index node_id: 1
  index user_id: 1
  index last_active_mark: -1
  index like_count: 1
  index suggested_at: 1
  index excellent: -1
end
