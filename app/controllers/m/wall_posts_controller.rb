class M::WallPostsController < ApplicationController
  def create
    @user_agent = UserAgent.parse(request.user_agent)
    user = User.find_by_uid(session[:facebook_uid])
    if user.nil?
      @wall_post = Wall_posts.new(wall_post_params)
    else
      @wall_post = user.wall_posts.new(wall_post_params)
    end
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
