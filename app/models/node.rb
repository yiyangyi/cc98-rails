class Node
  include Mongoid::Document

  field :name
  field :summary
  field :sort, type: Integer, default: 0
  field :topics_count, type: Integer, default: 0

  has_many :topics
  belongs_to :section
end
