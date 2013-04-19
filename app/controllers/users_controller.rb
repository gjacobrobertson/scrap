class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
    @transaction = Transaction.new(:to => @user)
  end

  def summary
    @user = User.find(params[:id])
    render :json => {:total => view_context.debt_total(@user), :summary => render_to_string(:partial => 'users/summary')}
  end
end
