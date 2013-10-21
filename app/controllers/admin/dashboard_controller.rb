class Admin::DashboardController < ApplicationController
  layout 'admin'
  
  def index
    @total_wall_posts_count = WallPost.count
    @heroes_count = Hero.registerd_heroes_count 
  end
  
  def wall_posts_count
    @wall_posts = WallPost.order("created_at desc")
  end
  
  def heroes_count
    @heroes = Hero.all
  end
  
end
