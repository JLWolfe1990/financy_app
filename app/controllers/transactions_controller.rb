class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all.page params[:page]
    @total = Transaction.not_excluded.sum(:amount)
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
