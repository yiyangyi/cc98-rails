class Append
  include Mongoid::Document
  include Mongoid::Timestamps

  field :topic_id, type: Integer
  field :content
  field :content_html
  field :append_at, type: DateTime

  belongs_to :topic, inverse_of: :appends

  index topic_id: 1
end
