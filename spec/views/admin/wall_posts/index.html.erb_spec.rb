require 'spec_helper'

describe "admin/wall_posts/index" do
  before(:each) do
    assign(:admin_wall_posts, [
      stub_model(Admin::WallPost),
      stub_model(Admin::WallPost)
    ])
  end

  it "renders a list of admin/wall_posts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
