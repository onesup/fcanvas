class MantoUser < ActiveRecord::Base
  devise :database_authenticatable, :omniauthable, :omniauth_providers => [:facebook]
  
  # has_one :token, as: :identifiable
  has_many :wall_posts
  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = self.find_by_uid(auth.uid)
    unless user
      user = self.new( name:auth.extra.raw_info.name,
                       provider:auth.provider,
                       uid:auth.uid,
                       email:auth.info.email,
                       password:Devise.friendly_token[0,20])
    end
    user.token = auth.credentials.token
    user.save!
    user
  end
  
  def self.fb_username_to_fb_id(username)
    username = username.gsub("https://www.facebook.com","").gsub("https://facebook.com","")
    username = username.gsub("http://www.facebook.com","").gsub("http://facebook.com","")
    oauth = Koala::Facebook::OAuth.new(
      FACEBOOK_CONFIG[:relay][:app_id], FACEBOOK_CONFIG[:relay][:app_secret]
    )
    graph = Koala::Facebook::API.new(oauth.get_app_access_token)
    begin
      graph.get_object(username)["id"]
    rescue
      ""
    end
  end
  
  def get_fb_profile_image
    oauth = Koala::Facebook::OAuth.new(
      FACEBOOK_CONFIG[:relay][:app_id], FACEBOOK_CONFIG[:relay][:app_secret]
    )
    graph = Koala::Facebook::API.new(self.token)
    begin
      graph.get_picture(self.uid,{type: "large"})
    rescue
      ""
    end
  end
  
  
  def self.create_or_find_fan!(uid, access_token)
    unless exists?(uid: uid)
      fan = MantoUser.new
      Token.create_or_update_token!(fan, access_token)
      fan.uid = uid
      fan.detail_from_facebook(access_token)
      fan.save
    else
      fan = find_by_uid(uid)
      Token.create_or_update_token!(fan, access_token)
      fan.detail_from_facebook(access_token)
      fan.save
    end
    # Token.create_or_update_token!(fan, access_token)
    fan
  end
  
  def detail_from_facebook(access_token)
    graph = Koala::Facebook::API.new(access_token)
    profile = graph.get_object("me")
    self.name = profile["name"]
    self.profile_image = graph.get_picture(profile["id"])
  end
end
