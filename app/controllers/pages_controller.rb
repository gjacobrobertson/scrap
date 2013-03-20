class PagesController < ApplicationController
  def home
    @split = Split.new
    render :welcome if not user_signed_in?
  end

  def welcome
  end

  def summary
    render :partial => 'shared/summary'
  end

  def notifications
    render :partial => 'shared/notifications'
  end
end
