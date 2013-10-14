require 'spec_helper'

describe PageTabController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'fan_gate'" do
    it "returns http success" do
      get 'fan_gate'
      response.should be_success
    end
  end

end
