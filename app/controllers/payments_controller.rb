class PaymentsController < ApplicationController
  before_filter :signed_in
  before_filter :creator, :only => [:edit, :update, :destroy]

  def create
    @payment = current_user.payments_from.build(params[:payment])
    if @payment.save
      flash[:success] = "Payment added"
      redirect_to @payment.to
    else
      flash.now[:error] = "Please enter a valid payment"
      @user = User.find(params[:payment][:to_id])
      render 'users/show'
    end
  end
  
  def edit
  end

  def update
    if @payment.update_attributes(params[:payment])
      flash[:success] = "Payment updated."
      redirect_to session[:return_to]
    else
      render 'edit'
    end
  end

  def destroy
    @payment.destroy
    flash[:success] = "Payment destroyed"
    redirect_to session[:return_to]
  end

  private

  def creator
    @payment = Payment.find(params[:id])
    redirect_to @payment.to unless current_user?(@payment.from)
  end
end
