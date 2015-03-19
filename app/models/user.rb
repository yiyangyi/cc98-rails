class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :email_public,       type: Mongoid::Boolean
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Custom field
  field :login
  field :name
  field :location
  field :location_id,        type: Integer
  field :bio
  field :tagline
  field :website
  field :private_token
  field :verified,           type: Mongoid::Boolean, default: false
  field :state,              type: Integer,          default: 1
  field :guest,              type: Mongoid::Boolean, defulat: false
  field :topics_count,       type: Integer,          default: 0
  field :replies_count,      type: Integer,          default: 0
  field :favorite_topic_ids, type: Array,            default: []

  scope :active, -> { desc(:replies_count, :topics_count) }

  has_many :notes
  has_many :photos
  has_many :topics,        dependent: :destroy
  has_many :replies,       dependent: :destroy
  has_many :notifications, class_name: 'Notification::Base', dependent: :destroy

  has_and_belongs_to_many :followers,       class_name: 'User', inverse_of: :followings
  has_and_belongs_to_many :followings,      class_name: 'User', inverse_of: :followers
  has_and_belongs_to_many :following_nodes, class_name: 'Node', inverse_of: :followers

  index login: 1
  index email: 1
  index location: 1

  mount_uploader :avartar, AvatarUploader

  validates :login, presence: true
  validates :login, uniqueness: true
  validates :login, length: 3..10
  validates :login, format: { with: /\A\w+\Z/, message: 'Only allow numbers, letters and underscores!' }


  STATE = { deleted: -1, normal: 1, blocked: 2 }

  def newbie?
    return false if self.verified == true
    self.created_at < 1.week.ago
  end

  def deleted?
    return self.state == STATE[:deleted]
  end

  def soft_delete
    self.email = "#{self.login}_#{self.id}@cc98.org"
    self.login = "Guest"
    self.bio = ""
    self.website = ""
    self.tagline = ""
    self.location = ""
    self.state = STATE[:deleted]
    self.save(validate: false)
  end

  def blocked?
    return self.state == STATE[:blocked]
  end

  def admin?
    Setting.admin_email.include?(self.email)
  end

  def has_role?(role)
    case role
      when :admin then admin?
      when :member then self.state = STATE[:normal]
      else false
    end
  end

  def like(likable)
    return false if likable.blank? or likable.liked_by_user?(self)
    likable.push(liked_user_ids: self.id)
    likable.inc(likes_count: 1)
    likable.touch
  end

  def unlike(likable)
    return false if likable.blank?
    return false if not likable.liked_by_user?(self)
    likable.pull(liked_user_ids: -1)
    likable.inc(likes_count: -1)
    likable.touch
  end

  def favorite_topic(topic_id)
    return false if topic_id.blank?
    topic_id = topic_id.to_i
    return false if self.favorite_topic_ids.include?(topic_id)
    self.push(favorite_topic_ids: topic_id)
    true
  end

  def unfavorite_topic(topic_id)
    return false if topic_id.blank?
    topic_id = topic_id.to_i
    self.pull(favorite_topic_ids: topic_id)
    true
  end
end
