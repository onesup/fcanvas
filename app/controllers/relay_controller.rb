class RelayController < ApplicationController
  layout 'relay'# , except: [:new, :edit]
  def index
    @user_agent = UserAgent.parse(request.user_agent)
    if @user_agent.mobile?
      redirect_to relay_mobile_path
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
      result = request["page"]["liked"]
    rescue
      result = "invalid!!!"
    end
    Rails.logger.info("@@@@@@@" + result.to_s)
    require_like(result)
  end
  
  def tab_fangate
  end
  
  def mobile_fangate
    Rails.logger.info "@@@@@@ fangate start @@@@@@@@"
    if params[:uid].nil? == false and MantoUser.exists?(uid: params[:uid]).nil? == false
      user = MantoUser.find_by_uid(params[:uid])
      if check_like(user) == true
        Rails.logger.info "@@@@@@ go to mobile_path"
        redirect_to mobile_relay_path({uid: params[:uid]})
      elsif check_like(user) == "auth error" or check_like(user) == "client error"
        redirect_to mobile_relay_login_path
      else
        render layout: 'mobile_relay'
      end
    else
      redirect_to mobile_relay_login_path
    end
  end
  
  def mobile_relay
    if params[:uid].nil? == false and MantoUser.exists?(uid: params[:uid]).nil? == false      
      user = MantoUser.find_by_uid(params[:uid])
      if check_like(user) == false
        redirect_to mobile_relay_login_path({uid: params[:uid]})
      else
      end
    else
      redirect_to mobile_relay_login_path
    end
  end
  
  def mobile_login
    layout 'mobile_relay'
    Rails.logger.info "@@@@@@ mobile_login start @@@@@@@@"
    if params[:uid].nil? == false and MantoUser.exists?(uid: params[:uid]).nil? == false
      user = MantoUser.find_by_uid(params[:uid])
      if check_like(user) == true
        Rails.logger.info "@@@@@@ go to mobile_path"
        redirect_to mobile_relay_path({uid: params[:uid]})
      else
        Rails.logger.info "@@@@@@ auth success"
        redirect_to mobile_relay_fangate_path({uid: params[:uid]})
      end
    else
      Rails.logger.info "@@@@@@ auth failed"
      # redirect_to mobile_relay_login_path
    end    
  end
  
  private
  
    def require_like(liked)
      unless liked.nil?
        if liked == false
          redirect_to tab_relay_fangate_path
        end
      end
    end
    
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
