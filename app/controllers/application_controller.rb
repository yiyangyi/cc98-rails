class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :unread_notify_count

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def set_seo_meta(title = '', meta_keyword = '', meta_description = '')
  	@page_title = "#{title}" if title.length > 0
  	@meta_keyword = meta_keyword
  	@meta_description = meta_description
  end

  def require_user
  	if current_user.blank?
  		respond_to do |format|
  			format.html { authenticate_user! }
  			format.all { head(:unauthorized) }
      end
  	end
  end

  def unread_notify_count
  	return 0 if current_user.blank?
  	@unread_notify_count ||= current_user.notifications.unread.count
  end

  def render_optional_error_file(status_code)
  	status = status_code.to_s
  	fname = %W(403 404 422 500).include?(status) ? status : 'unknow'
  	render template: "/errors/#{fname}", format: [:html],
  				 handler: [:erb], status: status, layout: 'application'
  end

  def render_403
  	render_optional_error_file(403)
  end

  def render_404
  	render_optional_error_file(404)
  end

end
