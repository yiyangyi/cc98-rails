class Location
  include Mongoid::Document

  field :name
  field :users_count, type: Integer, default: 0

  has_many :user

  scope :hot, -> { desc(:users_count) }

  index :name
end
