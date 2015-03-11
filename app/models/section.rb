class Section
  include Mongoid::Document

  field :name
  field :sort, type: Integer, default: 0

  has_many :nodes, dependent: :destroy
end
