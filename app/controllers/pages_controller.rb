class PagesController < ApplicationController
  def home
    @split = Split.new
    render :welcome if not user_signed_in?
  end

  def welcome
  end

  def summary
    render :partial => 'summary'
  end
end
