class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent.signed[:auth_token] = user.auth_token
      else
        cookies.signed[:auth_token] = user.auth_token
      end
      redirect_to root_url, notice: 'Logged in!'
    else
      flash.now.alert()
      render :new
    end
  end

  # DELETE /resource/sign_out
  def destroy
    cookie.delete :auth_token
    redirect_to root_url, notice: 'Logged out!'
  end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
