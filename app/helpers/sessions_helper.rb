module SessionsHelper

  def sign_in(user)
    session[:user_id] = user[:id]
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    session[:user_id] = nil
  end

  def deny_access
    redirect_to root_path, :notice => "Please sign in to access this page."
  end

  def current_user?(user)
    user == current_user
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end

  def signed_out
    redirect_to root_path if signed_in?
  end

  def signed_in
    deny_access unless signed_in?
  end

  def store_location
    session[:return_to] = request.fullpath
  end
end
