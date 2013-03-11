class SplitsController < ApplicationController
  before_filter :authenticate_user!

  def create
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
