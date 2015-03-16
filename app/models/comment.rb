class Comment
  include Mongoid::Document

  field :body
  field :body_html

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  index user_id: 1
  index commentable_id: 1
  index commentable_type: 1

  validates :body, presence: true
end
