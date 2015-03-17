class UserMailer < ApplicationMailer
  def welcome
    @user = User.find_by_id(params[:id])
    return false if @user.blank?
    mail(to: @user.email, subject: "")
  end
end
