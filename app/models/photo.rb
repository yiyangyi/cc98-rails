class Photo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :photo

  belongs_to :user
end
