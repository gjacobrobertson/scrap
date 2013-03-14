class TransactionsController < ApplicationController
  before_filter :authenticate_user!

  def create
    puts params[:transaction]
  end

  def edit
  end

  def update
  end

  def delete
  end
end
