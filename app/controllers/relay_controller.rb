class RelayController < ApplicationController
  layout 'relay'
  def index
    @user_agent = UserAgent.parse(request.user_agent)
    if @user_agent.mobile?
      redirect_to mobile_relay_path
    else
      redirect_to "https://www.facebook.com/miraclehospital/app_666292156743698"
    end
  end
  
  def tab_relay
    
  end
  
  def mobile_relay
    
  end
end