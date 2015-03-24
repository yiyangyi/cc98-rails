class Notification::TopicReply < Notification::Base
  belongs_to :reply

  delegate :body, to: :reply, prefix: true, allow_nil: false

  def notice_hash
  	return '' if self.reply.blank?
  	{
  	  title: '您关注的话题有了新回复。'
  	  content: self.reply_body[0, 30],
  	  content_path: self.content_path
  	}
  end

  def content_path
  end

end