class TransactionsController < ApplicationController
  def index
    @report = Report.new
    @transactions = Transaction.all.active

    @start_at = params[:start_at] ? DateTime.parse(params[:start_at]) : nil
    @end_at = params[:end_at] ? DateTime.parse(params[:end_at]) : nil

    @transactions = @transactions.range(@start_at, @end_at) if @start_at
    @total = @transactions.not_excluded.sum(:amount)

    @start_at_f = @start_at.try(:strftime, '%Y/%m/%d')
    @end_at_f = @end_at.try(:strftime, '%Y/%m/%d')
    @page = params[:page]
    @transactions = @transactions.page @page
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
