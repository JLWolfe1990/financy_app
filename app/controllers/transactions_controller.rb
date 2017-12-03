class TransactionsController < ApplicationController
  def index
  end

  def edit
  end

  def update
  end

  def show
    @transaction = Transaction.find(params.fetch(:id))
    render partial: 'transactions/show', layout: false
  end
end
