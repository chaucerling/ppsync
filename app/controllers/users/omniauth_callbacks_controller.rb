class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def provider(*args)
    args.each do |name|
      define_method name do
        @user = User.from_omniauth(request.env["omniauth.auth"], current_user)
        if @user.persisted?
          sign_in_and_redirect @user, :event => :authentication
          set_flash_message(:notice, :success, :kind => name) if is_navigational_format?               
        else
          session["devise.#{name}_data"] = request.env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end # define provider method
    end
  end

  provider :weibo

end