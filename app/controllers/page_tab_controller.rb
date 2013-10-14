class PageTabController < ApplicationController
  def index
    require_like
    @wall_post = WallPost.new
    @wall_posts = WallPost.all
  end

  def fan_gate
    
  end
  
  private

    def require_like
      unless request.env['facebook.params'].nil?
        facebook_params = request.env['facebook.params']
        if facebook_params['page']['liked'] == false
          redirect_to page_tab_gate_path
        else
          user = User.create_or_find_fan!(facebook_params['user_id'], facebook_params['oauth_token'])
          session[:facebook_uid] = user.uid
          session[:facebook_token] = user.token.access_token
        end
      end
    end
  
end
