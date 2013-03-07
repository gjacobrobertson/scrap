class SplitsController < ApplicationController
  def create
    @split = Split.new(params[:split])
    if @split.save
      render :json => @split.to_json
    else
      response.status = 403
      render :json => { :errors => @split.errors.full_messages }
    end
  end
end
