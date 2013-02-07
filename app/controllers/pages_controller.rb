class PagesController < ApplicationController
  def home
    render :welcome if not user_signed_in?
  end

  def welcome
  end
end
