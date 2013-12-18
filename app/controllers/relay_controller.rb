class RelayController < ApplicationController
  layout 'relay'
  def index
  end
  
  def relay
    render nothing: true
  end
end
