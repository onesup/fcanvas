class WallPost < ActiveRecord::Base
  belongs_to :user
  
  def post_message
    "영웅" + self.user.name + "짱짱맨님의 메세지" + self.message
  end
  
  def post
    user = self.user
    
    @oauth_token = user.token.access_token
    api = Koala::Facebook::API.new(@oauth_token)
    api.put_wall_post(self.post_message, 
    {
        :name => "Im a wall post",
        :link => "http://www.example.com",
        :caption => "Im a caption",
        :description => "Im a long description of an attachment",
        :picture => "http://www.example.com/picture.jpg" 
    })
  end
  
end
