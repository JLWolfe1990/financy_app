class ClassificationsController < ApplicationController
  before_action :find_object, only: [:show, :transactions]
  before_action :find_transactions, only: [:show, :transactions]

  def index
    @classifications = Classification.all.order(:group, :name)
  end

  def new
    @classification = Classification.new group: 'personal'
  end

  def create
    @classification = Classification.create classification_params
  end

  def update
  end

  def show
  end

  def destroy
    Classification.find(params.fetch(:id)).destroy!

    redirect_to classifications_path
  end

  def transactions
    render partial: 'transactions', layout: false
  end

  private

  def find_object
    @classification = Classification.find(params.fetch(:id))
  end

  def find_transactions
    @start_date = Date.parse(params[:start_date]) if params[:start_date]
    @end_date = Date.parse(params[:end_date]) if params[:end_date]

    @all_transactions = @classification.transactions.active

    @all_transactions = @all_transactions.range(@start_date, @end_date) if @start_date && @end_date

    @total = @all_transactions.sum(:amount)
    @transactions = @all_transactions.page(params[:page])
  end

  def classification_params
    params.require(:classification).permit(:name, :group, :excluded)
  end
end
