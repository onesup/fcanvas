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
    Rails.logger.info("@@@@@@@" + app_id + "@@@@@@" + app_secret)
    # request = oauth.parse_signed_request(params["signed_request"])
    # Rails.logger.info("@@@@@@@" + request["page"]["liked"].to_s)
  end
  
  def mobile_relay
    
  end
end
