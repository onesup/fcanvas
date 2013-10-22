require 'spec_helper'

describe "admin/wall_posts/edit" do
  before(:each) do
    @admin_wall_post = assign(:admin_wall_post, stub_model(Admin::WallPost))
  end

  it "renders the edit admin_wall_post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_wall_post_path(@admin_wall_post), "post" do
    end
  end
end
