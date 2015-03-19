class Node
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :summary
  field :sort, type: Integer, default: 0
  field :topics_count, type: Integer, default: 0

  has_many :topics
  belongs_to :section

  has_and_belongs_to_many :followers, class_name: 'User', inverse_of: :following_nodes

  index section_id: 1

  scope :hots, -> { desc(:topic_count) }
  scope :sorted, -> { desc(:sort) }
end
