class ApplicationController < ActionController::Base
  protect_from_forgery

  def approvals
    render :partial => 'layouts/approvals'
  end
end
