class Comment
  include Mongoid::Document

  field :body
  field :body_html

  belongs_to :commentable, polymorphic: true
  belongs_to :user
end
