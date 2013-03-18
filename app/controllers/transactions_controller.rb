class TransactionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :valid_user

  def approve
    @transaction.approve
    render :partial => 'shared/approvals'
  end

  def reject
    @transaction.reject
    render :partial => 'shared/approvals'
  end

  protected
  def valid_user
    @transaction = Transaction.find(params[:id])
    unless @transaction.to == current_user
      render :json => {:message => "Access Denied"}.to_json
    end
  end
end
