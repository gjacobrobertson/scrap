class PagesController < ApplicationController
  before_filter :store_location
  def home
    @user = current_user
    if @user.nil?
      @user = User.new
      @email = nil
      render 'landing', :layout => false
    else
      render 'home'
    end
  end
end
