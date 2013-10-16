class M::WallPostsController < ApplicationController
  def create
    @user_agent = UserAgent.parse(request.user_agent)

    @facebook_params = @oauth.get_user_info_from_cookies(cookies) if session[:facebook_token].nil?
    if session[:facebook_token].nil?
      access_token = @facebook_params['access_token']
      uid = @facebook_params['user_id']
    else
      access_token = session[:facebook_token]
      uid = session[:user_id]
    end
    @rest = Koala::Facebook::API.new(access_token)
    user = User.create_or_find_fan!(uid, access_token)
    
    @result = @rest.fql_query("SELECT page_id FROM page_fan WHERE uid=me() AND page_id=" + page_id)
    session[:facebook_uid] = user.uid
    session[:facebook_token] = user.token.access_token

    @wall_post = user.wall_posts.new(wall_post_params)    
    respond_to do |format|
      if @wall_post.save
        @wall_post.post
        flash[:popup] = "complete"
        format.html { redirect_to mobile_path}
        format.json { render json: @wall_post, status: :created, location: @wall_post }
      else
        flash[:popup] = "invalid"
        format.html { redirect_to mobile_path }
        format.json { render json: @wall_post.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private  
  
    def wall_post_params
      params.require(:wall_post).permit(:message, :user_id)
    end
  
end
