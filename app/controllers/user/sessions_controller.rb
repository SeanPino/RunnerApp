class User::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    resource = User.find_for_database_authentication(email: params[:user_login][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user_login][:password])
      sign_in("user", resource)
      resource.ensure_authentication_token!
      render 'api/v1/sessions/new.json.jbuilder', status: 201
      #redirect_to "/profile/show/"
      return
    end
    invalid_login_attempt
   end

  # DELETE /resource/sign_out
   def destroy
    super
   end

  # protected

  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
