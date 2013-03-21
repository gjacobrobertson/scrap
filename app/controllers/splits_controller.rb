class SplitsController < ApplicationController
  before_filter :authenticate_user!

  def create
    params[:split][:with].split(',').each do |uid|
      unless User.where(:provider => 'facebook', :uid => uid).first
        User.create(
          :name => FbGraph::User.fetch(uid).name,
          :provider => 'facebook',
          :uid => uid
        )
      end
    end
    @split = Split.new(params[:split])
    @split.from = current_user
    if @split.save
      render :partial => 'alert'
    else
      response.status = 403
      render :partial => 'alert'
    end
  end
end
