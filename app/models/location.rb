class Location
  include Mongoid::Document

  field :name
  field :users_count, type: Integer, default: 0

  has_many :user

  scope :hot, -> { desc(:users_count) }

  index :name

  validates :name, uniqueness: true

  def self.find_by_name(name)
  	return false if name.blank?
  	name = name.downcase.strip
  	query = name.match(/\p{Han}/) != nil ? name : "#{name}"
  	self.find(name: query).first
  end

  def self.find_or_create_by_name(name)
  	if not location = self.find_by_name(name)
  	  location = self.create(name: name.strip)
  	end
  	location
  end
end
