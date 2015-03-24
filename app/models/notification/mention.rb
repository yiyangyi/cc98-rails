class Notification::Mention < Notification::Base
  belongs_to :mentionable, polymorphic: true

  delegate :body, to: :mentionable, prefix: true, allow_nil: false
end
