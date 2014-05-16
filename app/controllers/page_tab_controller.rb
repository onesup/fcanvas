class PageTabController < ApplicationController
  def index
    session[:facebook_params] = request.env['facebook.params']
    require_like unless session[:facebook_params].nil?
    @wall_post = WallPost.new
    @wall_posts = WallPost.order('created_at DESC').page(params[:page]).per(5)
    @count = WallPost.count
  end

  def fan_gate
    
  end
  
  def test
    @wall_posts = WallPost.order('created_at desc').page(params[:page])
  end
  
  private

    def require_like
      facebook_params = session[:facebook_params]
      if facebook_params['page']['liked'] == false
        redirect_to page_tab_gate_path
      else
        begin
          user = User.create_or_find_fan!(facebook_params['user_id'], facebook_params['oauth_token'])
          session[:facebook_uid] = user.uid
          session[:facebook_token] = user.token.access_token
        rescue
          redirect_to page_tab_path
        end
      end

    end
  
end
