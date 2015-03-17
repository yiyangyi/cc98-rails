module Mongoid
  module BaseModel
    extend ActiveSupport::Concern

    included do
      scope :recent, -> { desc(:_id) }
      scope :exclude_ids, ->(ids) { where(:_id.nin => ids.map(&:to_i)) }
      scope :by_week, -> { where(:created_at.gte => 7.days.ago.utc) }
    end

    module ClassMethods
      def find_by_id(id)

      end

      def find_in_batches(opt = {})

      end

      def delay

      end
    end
  end
end