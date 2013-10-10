require 'spec_helper'

describe User do
  it "를 생성 할 때 겹치는 uid가 있으면 새로 생성하지않고 그대로 돌려준다." do
    uid = "100001176058018"
    token = FactoryGirl.create(:token)
    fan = User.create_or_find_fan!(uid, token.access_token)
    expect(User.create_or_find_fan!(uid, token.access_token)).to eql(fan)
  end
  
  it "를 생성하면 토큰 모델도 생성된다." do
    uid = "100001176058018"
    token = FactoryGirl.create(:token)
    fan = User.create_or_find_fan!(uid, token.access_token)
    expect(fan.token.nil?).to eql(false)
  end
  
  it "의 자세한 정보를 페북에서 가져오기" do
    user = FactoryGirl.create(:user, :with_token)
    puts user.detail_from_facebook
    expect(user.name).to eql("Wonsup Lee")
  end
end
