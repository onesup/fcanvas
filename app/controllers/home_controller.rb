require 'rack-facebook-signed-request'
class HomeController < ApplicationController
  after_filter :allow_iframe
  def index
    require_like unless request.env['facebook.params'].nil?
    @wall_post = WallPost.new
    @wall_posts = WallPost.all
  end
  
  def please_like_this_page

  end
  
  def canvas

  end
    
  private

    def require_like
      facebook_params = request.env['facebook.params']
      if facebook_params['page']['liked'] == false
        redirect_to please_like_this_page_path
      else
        user = User.create_or_find_fan!(facebook_params['user_id'], facebook_params['oauth_token'])
        session[:facebook_uid] = user.uid
        session[:facebook_token] = user.token.access_token
      end
    end
  
end
