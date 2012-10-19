class GroupsController < ApplicationController
  before_filter :store_location
  before_filter :signed_in
  before_filter :group_member, :only => [:edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @cost = Cost.new(:group_id => params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(params[:group])
    if @group.save
      @group.add_member(current_user)
      flash[:success] = "Group created"
      redirect_to @group
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @group.update_attributes(params[:group])
      flash[:success] = "Group updated."
      redirect_to @group
    else
      render 'edit'
    end
  end

  def destroy
    @group.destroy
    flash[:sucess] = "Group destroyed"
    redirect_to root_path
  end

  def join
    @group = Group.find(params[:id])
    @group.add_member(current_user)
    flash.now[:success] = "Successfully joined group"
    redirect_to @group
  end

  def leave
    @group = Group.find(params[:id])
    @group.remove_member(current_user)
    flash.now[:notice] = "You have left the group"
    redirect_to @group
  end

  private

  def group_member
    @group = Group.find(params[:id])
    redirect_to root_path unless @group.member?(current_user)
  end
end
