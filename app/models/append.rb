class Append
  include Mongoid::Document

  field :topic_id, type: Integer
  field :content
  field :content_html
  field :append_at, type: DateTime

  belongs_to :topic, inverse_of: :appends
end
