class Hero < ActiveRecord::Base
  self.table_name = "heroes"
  
  belongs_to :user
  belongs_to :wall_post
  
  # def self.registerd_heroes_count
  #   result = 0
  #   result = Hero.last.heroes_total unless Hero.count == 0
  #   result
  # end
  
  def self.registerd_heroes_count
    result = 0
    result = Hero.last.messages_total unless Hero.count == 0
    result
  end
  
  def self.registering(user)
    total_heroes = Hero.count == 0 ?  0 : Hero.last.heroes_total
    total_messages = Hero.count == 0 ?  0 : Hero.last.messages_total
    if user.wall_posts.count == 1
      total_heroes += 1
      total_messages += 1
      hero = Hero.create(heroes_total: total_heroes, user: user, messages_total: total_messages)
      total = [total_heroes, total_messages]
    else
      total_messages += 1
      hero = Hero.create(heroes_total: total_heroes, user: user, messages_total: total_messages)
      total = [total_heroes, total_messages]
    end
    total
  end

end
