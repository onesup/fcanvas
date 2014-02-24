class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = MantoUser.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    if @user.persisted?
      redirect_to relay_mobile_url({uid: @user.uid})
      # sign_in_and_redirect relay_mobile_url({uid: @user.uid}), :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to relay_mobile_login
    end
  end
end