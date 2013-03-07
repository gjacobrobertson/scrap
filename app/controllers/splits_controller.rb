class SplitsController < ApplicationController
  def create
    @split = Split.new(params[:split])
    if @split.save
      render :json => @split
    else
      render :json => {:error => "Shit Broke"}
    end
  end
end
