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

  validates_presence_of :user_id, :title, :body, :node

  index node_id: 1
  index user_id: 1
  index last_active_mark: -1
  index likes_count: 1
  index suggested_at: 1
  index excellent: -1

  scope :no_reply, -> { where(replies_count: 0) }
  scope :high_replies, -> { desc(:replies_count, :_id) }
  scope :high_likes, -> { desc(:likes_count, :_id) }
  scope :last_activated, -> { desc(:last_active_mark) }
  scope :suggest, -> { where(:suggested_at.ne => nil).desc(:suggested_at) }
  scope :popluar, -> { where(:like_count.gt => 5 ) }
  scope :excellent, -> { where(:excellent.gte => 1) }
  scope :without_node_ids, Proc.new { |ids| where(:node_ids.nin => ids) }

  searchable do
    text :title, :boost => 5.0
    text :body_html
    time :created_at
  end

  def push_followers(uid)
    return false if self.uid == uid
    return false if self.follower_ids.include?(uid)
    self.push(follower_ids: uid)
    true
  end

  def pull_followers(uid)
    return false if self.uid == uid
    self.pull(follower_ids: uid)
    true
  end

  def excellent?
    self.excellent > 0
  end
end
