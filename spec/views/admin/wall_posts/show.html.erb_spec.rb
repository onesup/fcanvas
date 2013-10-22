require 'spec_helper'

describe "admin/wall_posts/show" do
  before(:each) do
    @admin_wall_post = assign(:admin_wall_post, stub_model(Admin::WallPost))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
