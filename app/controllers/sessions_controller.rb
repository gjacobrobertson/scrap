class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in"
      redirect_to session[:return_to]
    else
      flash.now[:error] = "Invalid email or password"
      @email = params[:session][:email]
      @user = User.new
      render "pages/landing", :layout => false
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

  def new
    redirect_to 'pages/landing'
  end
end
