class CostsController < ApplicationController
  before_filter :signed_in
  before_filter :creator, :only => :destroy

  def create
    @cost = current_user.expenses.build(params[:cost]) 
    if @cost.save
      flash[:success] = "Cost created"
      redirect_to @cost.group
    else
      flash.now[:error] = "Shit broke"
      render 'groups/show', :id => params[:cost][:group_id]
    end
  end

  def destroy
    @cost.destroy
    flash[:sucess] = "Cost destroyed"
    redirect_to @cost.group
  end

  def creator
    @cost = Cost.find(params[:id])
    redirect_to @cost.group unless current_user?(@cost.user)
  end
end
