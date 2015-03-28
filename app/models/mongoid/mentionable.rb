module Mongoid
  module Mentionable
    include ActiveSupport::Concern

    included do
      field :mentioned_user_ids, type: Array, default: []
    end

    def mentioned_users
      User.where(:_id.in => mentioned_user_ids)
    end
  end
end
