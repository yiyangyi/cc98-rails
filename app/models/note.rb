class Note
  include Mongoid::Document

  field :title
  field :body
  field :word_count, type: Integer
  field :changes_count, type: Integer, default: 0
  field :publish, type: Mongoid::Boolean, default: false

  belongs_to :user

  index user_id: 1
  index updated_at: -1

  scope :published, -> { where(publish: true) }
  scope :recent_updated, -> { desc(updated_at) }
end
