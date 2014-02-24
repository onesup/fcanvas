class Relay::MobileController < ApplicationController
  layout 'mobile_relay'
  
  def fangate
    Rails.logger.info "@@@@@@ fangate start @@@@@@@@"
    if params[:uid].nil? == false and MantoUser.exists?(uid: params[:uid]).nil? == false
      user = MantoUser.find_by_uid(params[:uid])
      if check_like(user) == true
        Rails.logger.info "@@@@@@ go to mobile_path"
        redirect_to relay_mobile_path({uid: params[:uid]})
      elsif check_like(user) == "auth error" or check_like(user) == "client error"
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
      if check_like(user) == false
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
      if check_like(user) == true
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
  
  private
      
    def check_like(user)
      page_id = FACEBOOK_CONFIG[:relay][:page_id]
      token = user.token
      api = Koala::Facebook::API.new(token)
      result = false
      begin
        query = api.get_connections("me","likes/" + page_id)
        result = true unless query.empty?
        info = "true"
      rescue Koala::Facebook::AuthenticationError
        Rails.logger.info "auth error!! uid: " + user.uid
        session[:facebook_uid] = nil
        result = false
        info = "auth error"
      rescue Koala::Facebook::ClientError
        Rails.logger.info "client error!! uid: " + user.uid
        session[:facebook_uid] = nil
        result = false
        info = "client error"
      end
      Rails.logger.info "@@@@@check_like: "+ result.to_s
      return result
    end
end
