class MController < ApplicationController
  layout 'mobile'
  def index
    @result = require_like
    if @result == []
      redirect_to mobile_gate_path
    end
  end

  def fan_gate
    @result = require_like
    unless @result == []
      redirect_to mobile_path
    end
  end
  
  private
    def require_like
      page_id = FACEBOOK_CONFIG[:page_id]
      @oauth = Koala::Facebook::OAuth.new(FACEBOOK_CONFIG[:app_id], FACEBOOK_CONFIG[:app_secret])
      @facebook_params = @oauth.get_user_info_from_cookies(cookies) if session[:facebook_token].nil?
      if session[:facebook_token].nil?
        access_token = @facebook_params['access_token']
        uid = @facebook_params['user_id']
      else
        access_token = session[:facebook_token]
        uid = session[:user_id]
      end
      @new_access_info = @oauth.exchange_access_token_info(access_token)
      @rest = Koala::Facebook::RestAPI.new(access_token)
      user = User.create_or_find_fan!(uid, access_token)
      session[:facebook_uid] = user.uid
      session[:facebook_token] = user.token.access_token
      @result = @rest.fql_query("SELECT page_id FROM page_fan WHERE uid=me() AND page_id=" + page_id)
    end
end
