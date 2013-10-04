# require 'rack/facebook/signed_request'
class HomeController < ApplicationController
  after_filter :allow_iframe
  def index    
    if request.env['facebook.params']["page"]["liked"] == false
      redirect_to pleas_like_this_page_path
    end
  end
  
  def please_like_this_page

  end
  
  
  def allow_iframe
    response.headers["X-Frame-Options"] = "GOFORIT"
    # response.headers["X-Frame-Options"] = "SAMEORIGIN"
  end
  
end
