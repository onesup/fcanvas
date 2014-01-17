class RelayController < ApplicationController
  layout 'relay'
  def index
    @user_agent = UserAgent.parse(request.user_agent)
    if @user_agent.mobile?
      redirect_to mobile_relay_path
    else
      redirect_to FACEBOOK_CONFIG[:relay][:app_address]
    end
  end
  
  def tab_relay
    app_id = FACEBOOK_CONFIG[:relay][:app_id]
    app_secret = FACEBOOK_CONFIG[:relay][:app_secret]
    oauth = Koala::Facebook::OAuth.new(app_id, app_secret)
    begin
      request = oauth.parse_signed_request(params["signed_request"])
    rescue
      request["page"]["liked"] = "@@@@@@invalid!!!!"
    end
    require_like(request["page"]["liked"])
  end
  
  def tab_fangate
  end
  
  def mobile_relay
    
  end

  private
  
    def require_like(liked)
      unless liked.nil?
        if liked == false
          redirect_to tab_relay_fangate_path
        end
      end
    end
  
end
