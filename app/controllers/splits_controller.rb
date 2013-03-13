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
      render :json => @split.to_json
    else
      response.status = 403
      render :json => { :errors => @split.errors.full_messages }
    end
  end
end
