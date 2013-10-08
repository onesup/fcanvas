class User < ActiveRecord::Base
  has_one :token, as: :identifiable
  has_many :wall_posts
  
  def self.create_fan!(uid, access_token)
    unless exists?(uid: uid)
      fan = create!(uid: uid)
    else
      fan = find_by_uid(uid)
    end
    Token.create_or_update_token!(fan, access_token)
    fan
  end
end
