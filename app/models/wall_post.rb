class WallPost < ActiveRecord::Base
  belongs_to :user
  validates :message, presence: true
  def post_message
    '"' + self.message + '" 라고
    ' +
    '' + self.user.name + 
    '영웅이 말씀하셨습니다.

    영웅의 한마디가 기부금으로 전환되어 
    기적의 어린이재활병원 건립 후원금으로 
    지원됩니다.

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
  end
  
  # def post
  #   # api = Koala::Facebook::API.new(self.user.token.access_token)
  #   # picture = Koala::UploadableIO.new(File.open(Rails.root.to_s+"/app/assets/images/posting_img.jpg"))
  #   # api.put_connections("me", "namespace.listen", {
  #   #   # "image[0][url]" => "http://farm4.staticflickr.com/3665/10288523825_3fea0316ef_o.jpg",
  #   #   # "image[0][user_generated]" => "true",
  #   #   :article => "Hello, world"})
  #   
  #   # Koala::Facebook::API.new(access_token).put_connections(
  #   #   uid,
  #   #   "namespace:action",
  #   #   "image[0][user_generated]" => true,
  #   #   "image[0][url]" => "[URL_TO_USER_GENERATED_IMAGE]",
  #   #   "fb:explicitly_shared" => true,
  #   #   "message" => "[DESCRIPTION]")
  #   
  # end
  
  # def post
  #   # dir = Dir.pwd.concat(Rails.root.to_s+"/app/assets/images")
  #   fb_url = URI.parse("https://graph.facebook.com/#{self.user.uid}/feed")
  #   img = File.open(Rails.root.to_s+"/app/assets/images/posting_img.jpg")
  #   req = Net::HTTP::Post::Multipart.new(
  #     "#{fb_url.path}?access_token=#{self.user.token.access_token}", 
  #     "source" => UploadIO.new(img, "application/jpg", img.path),
  #     "message" => self.post_message
  #   ) 
  #   n = Net::HTTP.new(fb_url.host, fb_url.port)
  #   n.use_ssl = true
  #   n.verify_mode = OpenSSL::SSL::VERIFY_NONE
  #   n.start do |http|
  #     @result = http.request(req)
  #   end
  # end
end
