class PagesController < ApplicationController
  def home
    @split = Split.new
    render :welcome if not user_signed_in?
    puts current_user.credits
  end

  def welcome
  end
end
