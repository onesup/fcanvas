class RelayCampaignController < ApplicationController
  FACEBOOK_CONFIG = {
    :page_id=>"1377173915843709", 
    :app_id=>"666292156743698", 
    :app_secret=>"53a9b2e4f6781ad1852290626c0a91bb", 
    :domain => "ssl.minivertising.kr", 
    :page_address => "https://www.facebook.com/pages/ThchStartup/1377173915843709?id=1377173915843709&sk=app_166052670263191"
  }
  layout 'relay'
  def index

  end
end
