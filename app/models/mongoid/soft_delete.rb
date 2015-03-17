module Mongoid
  module SoftDelete
    extend ActiveSupport::Concern

    included do
      field :deleted_at, type: DateTime

      default_scope { where(deleted_at: nil) }
      alias_method :destroy!, :destroy
    end

    def destroy
      run_callbacks(:destroy) do
        if persisted?
          self.set(deleted_at: Time.now.utc)
          self.set(updated_at: Time.now.utc)
        end

        @destroyed = true
      end
    end

    def deleted?
      !self.deleted_at.nil?
    end
  end
end

