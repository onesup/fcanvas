# require 'rack/facebook/signed_request'
class HomeController < ApplicationController
  after_filter :allow_iframe
  def index
    facebook_params = request.env['facebook.params']
    session[:facebook_uid] ||= facebook_params['user_id']
    session[:facebook_token] ||= facebook_params['user_id']
    unless facebook_params.nil?
      if facebook_params['page']['liked'] == false
        redirect_to pleas_like_this_page_path
      else
        User.create_fan!(facebook_params['user_id'], facebook_params['oauth_token'])
      end
    end
    
    user = User.find_by_uid(facebook_params['user_id'])
    @wall_post = WallPost.new
    @wall_posts = WallPost.all
  end
  
  def please_like_this_page

  end
  
  
  def allow_iframe
    response.headers["X-Frame-Options"] = "GOFORIT"
  end
  
end
