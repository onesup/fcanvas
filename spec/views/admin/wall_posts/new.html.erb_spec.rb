require 'spec_helper'

describe "admin/wall_posts/new" do
  before(:each) do
    assign(:admin_wall_post, stub_model(Admin::WallPost).as_new_record)
  end

  it "renders new admin_wall_post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_wall_posts_path, "post" do
    end
  end
end
