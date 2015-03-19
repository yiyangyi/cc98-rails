class NotificationsController < ApplicationController
  before_action :require_user

  def index
    @notifications = current_user.notifications.recent
    current_user.read_notifications(@notifications)
  end

  def clear
    current_user.notifications.delete_all
    respond_with do |format|
      format.html { redirect_to notifications_path }
      format.js { render layout: false }
    end
  end

  def delete
    @notification = current_user.notifications.find(params[:id])
    @notification.delete
    respond_with do |format|
      format.html { redirect_to notifications_path }
      format.js { render layout: false }
    end
  end

  def destroy
    @notification = current_user.notifiacations.find(params[:id])
    @notification.destroy
    respond_with do |format|
      format.html { redirect_to notifications_path }
      format.js { render layout: false }
    end
  end
end
