class Photo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :photo

  belongs_to :user

  mount_uploader :photo, PhotoUploader
end
