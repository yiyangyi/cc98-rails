class Notification::Mention < Notification::Base
  belongs_to :mentionable, polymorphic: true

  delegate :body, to: :mentionable, prefix: true, allow_nil: false

  def notice_hash
  	return if self.mentionable.blank?
  	{
  	  title: [self.mentionable.login, "提及你："].join(' '),
  	  content: self.mentionable_body[0, 30],
  	  content_path: self.content_path
  	}
  end

  def content_path
  end
  
end
