class ApplicationController < ActionController::Base
  protect_from_forgery

  def approvals
    render :partial => 'shared/approvals'
  end
end
