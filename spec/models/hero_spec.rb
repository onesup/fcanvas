require 'spec_helper'

describe Hero do
  it "가 응원을 하면 숫자가 올라간다." do
    18.times do |n|
      user = User.create()
      wall_post = user.wall_posts.create()
      Hero.registering(user)
    end
    expect(Hero.last.total).to eql 18
  end
end
