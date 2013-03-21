class SplitsController < ApplicationController
  before_filter :authenticate_user!

  def create
    with = params[:split][:with].split(',').collect do |uid|
      user = User.where(:provider => 'facebook', :uid => uid).first
      unless user 
        user = User.create(
          :name => FbGraph::User.fetch(uid).name,
          :provider => 'facebook',
          :uid => uid
        )
      end
      user
    end
    @split = Split.new(params[:split].merge :from => current_user, :with => with)
    if @split.save
      render :partial => 'alert'
    else
      response.status = 403
      render :partial => 'alert'
    end
  end
end
