class Notification::TopicReply < Notification::Base
  belongs_to :reply

  delegate :body, to: :reply, prefix: true, allow_nil: false

  def notice_hash
  end

  def content_path
  end

end