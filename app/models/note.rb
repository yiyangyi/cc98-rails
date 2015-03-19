class Note
  include Mongoid::Document
  include Mongoid::Timestamps

  before_save :auto_set_value
  before_update :update_changes_count

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

  def auto_set_value
    if !self.body.blank?
      self.title = self.body.split("\n").first[0..50]
      self.word_count = self.body.length
    end
  end

  def update_changes_count
    self.changes_count = 0 if self.changes_count.blank?
    self.inc(changes_count: 1.)
  end
end
