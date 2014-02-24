class Relay::MobileController < ApplicationController
  layout 'mobile_relay'
  
  def fangate
    Rails.logger.info "@@@@@@ fangate start @@@@@@@@"
    if params[:uid].nil? == false and MantoUser.exists?(uid: params[:uid]).nil? == false
      user = MantoUser.find_by_uid(params[:uid])
      Rails.logger.info("relay/mobile#fangate")
      result = user.check_like
      Rails.logger.info("@@@@@check_like: "+result.to_s)
      if result == true
        Rails.logger.info "@@@@@@ go to mobile_path"
        redirect_to relay_mobile_path({uid: params[:uid]})
      elsif result == "auth error" or result == "client error"
        redirect_to relay_mobile_login_path
      else
        # render layout: 'mobile_relay'
      end
    else
      redirect_to relay_mobile_login_path
    end
  end
  
  def index
    if params[:uid].nil? == false and MantoUser.exists?(uid: params[:uid]).nil? == false      
      user = MantoUser.find_by_uid(params[:uid])
      Rails.logger.info("relay/mobile#index")
      result = user.check_like
      binding.pry
      Rails.logger.info("@@@@@check_like: "+result.to_s)
      if result == false
        redirect_to relay_mobile_fangate_path({uid: params[:uid]})
      else
      end
    else
      redirect_to relay_mobile_login_path
    end
  end
  
  def login
    Rails.logger.info "@@@@@@ mobile_login start @@@@@@@@"
    if params[:uid].nil? == false and MantoUser.exists?(uid: params[:uid]).nil? == false
      user = MantoUser.find_by_uid(params[:uid])
      Rails.logger.info("relay/mobile#login")
      result = user.check_like
      Rails.logger.info("@@@@@check_like: "+result.to_s)
      if result == true
        Rails.logger.info "@@@@@@ go to mobile_path"
        redirect_to relay_mobile_path({uid: params[:uid]})
      else
        Rails.logger.info "@@@@@@ auth success but need to go to fangate"
        redirect_to relay_mobile_fangate_path({uid: params[:uid]})
      end
    else
      Rails.logger.info "@@@@@@ auth failed"
    end    
  end
      
end
