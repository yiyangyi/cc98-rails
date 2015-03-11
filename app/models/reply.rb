class Reply
  include Mongoid::Document

  field :body
  field :body_html
  field :source
  field :message_id
end
