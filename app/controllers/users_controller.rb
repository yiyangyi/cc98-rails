class UsersController < ApplicationController
  def index
  end

  def show
  end

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
