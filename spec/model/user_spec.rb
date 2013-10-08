require 'spec_helper'

describe User do
  it "를 생성 할 때 겹치는 uid가 있으면 새로 생성하지않고 그대로 돌려준다." do
    fan = User.create_fan!("111","token")
    expect(User.create_fan!("111", "token")).to eql(fan)
  end
  
  it "를 생성하면 토큰 모델도 생성된다." do
    fan = User.create_fan!("111", "token")
    expect(fan.token.nil?).to eql(false)
  end
  
end
