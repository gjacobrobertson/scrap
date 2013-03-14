class TransactionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :valid_user

  def approve
    @transaction.approve
    render :json => {:message => "Approve"}.to_json
  end

  def reject
    @transaction.reject
    render :json => {:message => "Rejected"}.to_json
  end

  protected
  def valid_user
    @transaction = Transaction.find(params[:id])
    unless @transaction.to == current_user
      render :json => {:message => "Access Denied"}.to_json
    end
  end
end
