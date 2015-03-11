class Topic
  include Mongoid::Document

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
end
