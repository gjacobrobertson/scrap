class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def summary
    @user = User.find(params[:id])
    render :partial => 'users/summary'
  end
end
