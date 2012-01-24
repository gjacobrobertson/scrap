class PagesController < ApplicationController
  before_filter :store_location
  def home
    @user = current_user
  end
end
