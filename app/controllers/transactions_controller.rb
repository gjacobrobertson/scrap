class TransactionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :to_current_user, :only => [:approve, :reject]
  before_filter :from_current_user, :only => [:edit, :update, :destroy]

  def create
    @transaction = Transaction.new(params[:transaction])
    @transaction.from = current_user
    unless @transaction.save
      response.status = 403
    end
    render :partial => 'shared/alert', :locals => { :object => @transaction }
  end

  def approve
    @transaction.approve
    render :partial => 'shared/notifications'
  end

  def reject
    @transaction.reject
    render :partial => 'shared/notifications'
  end

  def destroy
    @transaction.delete
    render :partial => 'shared/notifications'
  end

  def edit
    render :partial => 'transactions/form'
  end

  def update
    @transaction.confirmed = nil
    if @transaction.update_attributes(params[:transaction])
      render :partial => 'shared/notifications'
    else
      response.status = 403
      render :partial => 'shared/errors.html.erb', :object => @transaction
    end
  end

  protected
  def to_current_user
    @transaction = Transaction.find(params[:id])
    unless @transaction.to == current_user
      render :json => {:message => "Access Denied"}.to_json
    end
  end

  def from_current_user
    @transaction = Transaction.find(params[:id])
    unless @transaction.from == current_user
      render :json => {:message => "Access Denied"}.to_json
    end
  end
end
