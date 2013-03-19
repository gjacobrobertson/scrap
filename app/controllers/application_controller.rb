class ApplicationController < ActionController::Base
  protect_from_forgery

  def notifications
    render :partial => 'shared/notifications'
  end
end
