class User
  include Mongoid::Document
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
  field :topic_count,        type: Integer,          default: 0
  field :replies_count,      type: Integer,          default: 0
  field :favorite_topic_ids, type: Array,            default: []
  
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
end
