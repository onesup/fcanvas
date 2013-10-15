class PageTabController < ApplicationController
  def index
    require_like unless flash[:facebook_params].nil?
    @wall_post = WallPost.new
    @wall_posts = WallPost.limit(5).order('created_at DESC')
    
  end

  def fan_gate
    
  end
  
  private

    def require_like
      facebook_params = flash[:facebook_params]
      if facebook_params['page']['liked'] == false
        redirect_to page_tab_gate_path
      else
        user = User.create_or_find_fan!(facebook_params['user_id'], facebook_params['oauth_token'])
        session[:facebook_uid] = user.uid
        session[:facebook_token] = user.token.access_token
      end

    end
  
end
