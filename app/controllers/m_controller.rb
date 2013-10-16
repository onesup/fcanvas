class MController < ApplicationController
  layout 'mobile'

  def index
    # session[:facebook_uid] ||= request.env['facebook.params']["user_id"]
    # unless request.env['facebook.params'].nil?
    #   @result = require_like
    #   if @result == []
    #     redirect_to mobile_gate_path
    #   end    
    #   unless session[:facebook_token] == request.env['facebook.params']["oauth_token"]
    #     session[:facebook_token] = request.env['facebook.params']["oauth_token"]
    #   end
    # end
    page_id = FACEBOOK_CONFIG[:page_id]
    @oauth = Koala::Facebook::OAuth.new(FACEBOOK_CONFIG[:app_id], FACEBOOK_CONFIG[:app_secret])
    if session[:facebook_token].nil?
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
      
      @result = @rest.fql_query("SELECT page_id FROM page_fan WHERE uid=me() AND page_id=" + page_id)
      unless @result == []
        # redirect_to 
      end
      session[:facebook_uid] = user.uid
      session[:facebook_token] = user.token.access_token
    end
    @wall_post = WallPost.new
    @wall_posts = WallPost.limit(5).order('created_at DESC')
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
      # uid = session[:facebook_uid]
      # access_token = session[:facebook_token]
      # session[:facebook_uid] = user.uid
      # session[:facebook_token] = user.token.access_token
      user = User.create_or_find_fan!(uid, access_token)
      @rest = Koala::Facebook::RestAPI.new(access_token)
      begin
        @result = @rest.fql_query("SELECT page_id FROM page_fan WHERE uid=me() AND page_id=" + page_id)
      # rescue Koala::Facebook::AuthenticationError
      #   @result = []
      # rescue Koala::Facebook::ClientError
      #   @result = []
      end
    end
        
end
