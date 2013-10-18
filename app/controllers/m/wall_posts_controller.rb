class M::WallPostsController < ApplicationController
  def create
    uid = params[:uid]
    access_token = params[:access_token]
    user = User.find_by_uid(uid)
    wall_post = user.wall_posts.new(wall_post_params)
    respond_to do |format|
      if wall_post.save
        wall_post.post
        flash[:popup] = "complete"
        format.html { redirect_to mobile_path}
        format.json { render json: wall_post, status: :created, location: wall_post }
      else
        flash[:popup] = "invalid"
        format.html { redirect_to mobile_path }
        format.json { render json: wall_post.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private  

    def wall_post_params
      params.require(:wall_post).permit(:message, :user_id)
    end
  
end
