# require 'rack/facebook/signed_request'
class HomeController < ApplicationController
  after_filter :allow_iframe
  def index
    facebook_params = request.env['facebook.params']
    unless facebook_params.nil?
      if facebook_params['page']['liked'] == false
        redirect_to pleas_like_this_page_path
      else
        user = User.create_or_find_fan!(facebook_params['user_id'], facebook_params['oauth_token'])
        session[:facebook_uid] = user.uid
        session[:facebook_token] = user.token.access_token
      end
    end
    @wall_post = WallPost.new
    @wall_posts = WallPost.all
  end
  
  def please_like_this_page

  end
  
  
  def allow_iframe
    response.headers["X-Frame-Options"] = "GOFORIT"
  end
  
end
