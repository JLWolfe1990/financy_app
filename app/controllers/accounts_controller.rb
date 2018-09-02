class AccountsController < ApplicationController
  def new
    @account = Account.new
  end

  def create
    @account = Account.new object_params
    if @account.save
      redirect_to accounts_path
    else
      render :new
    end
  end

  def update
    @account = Account.find(params.fetch(:id))
    @account.update name: object_params[:name]

    redirect_to account_transactions_path(account_id: @account.id)
  end

  def edit
    @account = Account.find(params.fetch(:id))
  end

  def index
    @accounts = Account.order(:created_at)
  end

  def fetch_transactions
    @account = Account.find(params.fetch(:id))
    @account.fetch_transactions!

    Rule.apply_all

    @account.update! last_synced_at: DateTime.now
    redirect_to account_transactions_path(account_id: @account.id)
  end

  def transactions
    Transaction.transaction do
      @account = Account.find(params.fetch(:account_id))
      @transactions = @account.transactions.focus.page(params[:page]).per(50)
      @total = @account.transactions.focus.sum(:amount)
    end
  end

  def destroy
    @account = Account.find(params.fetch(:id))
    @account.destroy!

    redirect_to accounts_path
  end

  private

  def object_params
    params.require(:account).permit(:name, :user_id, :plaid_institution_id)
  end
end
