class Photo
  include Mongoid::Document

  field :photo

  belongs_to :user
end
