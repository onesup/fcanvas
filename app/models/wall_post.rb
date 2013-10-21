class WallPost < ActiveRecord::Base
  belongs_to :user
  validates :message, presence: true
  def post_message
'"' + self.message + '" 라고
' +
'' + self.user.name + 
'영웅이 말씀하셨습니다.

영웅의 한마디가 기부금으로 전환되어 
기적의 어린이재활병원 건립 후원금으로 지원됩니다.

지금 기적을 만드는 영웅이 되어주세요!

참여하기 ▶ http://bit.ly/173wYGA'
  end
  
  def post
    user = self.user
    api = Koala::Facebook::API.new(self.user.token.access_token)
    picture = Koala::UploadableIO.new(File.open(Rails.root.to_s+"/app/assets/images/posting_img.jpg"))
    begin 
      api.put_picture(Rails.root.to_s+"/app/assets/images/posting_img.jpg","image/jpeg", {:message => self.post_message})
    rescue Koala::Facebook::AuthenticationError
      
    end
    Hero.registering(user)
  end
end
