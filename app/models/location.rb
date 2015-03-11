class Location
  include Mongoid::Document

  field :name
  field :users_count, type: Integer, default: 0
end
