require 'spec_helper'

describe Hero do
  it "가 글을 두 번 쓰면 0 반환" do
    user = User.create()
    wall_post = user.wall_posts.create(message: "hi mate")
    wall_post = user.wall_posts.create(message: "hi mate")
    expect(Hero.registering(user).first).to eql 0
  end
  it "가 글을 한 번 쓰면 1 반환" do
    user = User.create()
    wall_post = user.wall_posts.create(message: "hi mate")
    expect( Hero.registering(user).first).to eql 1
  end
  it "가 응원을 하면 숫자가 올라간다." do
    18.times do |n|
      user = User.create()
      wall_post = user.wall_posts.create(message: "hi mate")
      Hero.registering(user)
    end
    expect(Hero.last.heroes_total).to eql 18
  end
  it "가 응원을 여러번해도 숫자는 한번만 올라간다." do
    18.times do |n|
      user = User.create()
      wall_post = user.wall_posts.create(message: "hi mate")
      Hero.registering(user)
      wall_post = user.wall_posts.create(message: "hi mate")
      Hero.registering(user)
    end
    expect(Hero.last.heroes_total).to eql 18
  end
  
  it "가 응원을 여러번하면 응원 숫자는 매번 올라간다." do
    18.times do |n|
      user = User.create()
      wall_post = user.wall_posts.create(message: "hi mate")
      Hero.registering(user)
      wall_post = user.wall_posts.create(message: "hi mate")
      Hero.registering(user)
    end
    expect(Hero.last.messages_total).to eql 36
  end
  
  
end
