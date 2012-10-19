class UsersController < ApplicationController
  before_filter :store_location
  before_filter :signed_in, :only => [:index, :show, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update, :destroy]
  before_filter :signed_out, :only => [:new, :create]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @payment = Payment.new(:to_id => params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome to Scrap"
      redirect_to root_path
    else
      render 'pages/landing', :layout => false
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    sign_out
    @user.destroy
    flash[:success] = "Account destroyed"
    redirect_to root_path
  end
end
