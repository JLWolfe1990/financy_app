class RulesController < ApplicationController
  before_action :populate_similar_transactions, only: [:new, :create]

  def index
    @rules = Rule.all.page params[:page]
  end

  def new
    @rule = Rule.new
  end

  def create
    @rule = Rule.new create_params

    Rule.transaction do
      if @rule.save
        @rule.apply!(current_user)
        redirect_to new_rule_path
      else
        render :new
      end
    end
  end

  def edit
    @rule = Rule.find(params.fetch(:id))
  end

  def update
    @rule = Rule.find(params.fetch(:id))

    Rule.transaction do
      if @rule.update update_params
        @rule.reapply!(current_user)
        redirect_to new_rule_path
      end
    end
  end

  def apply
  end

  def show
    @rule = Rule.find(params.fetch(:id))
    @all_transactions = @rule.transactions
    @start_date = Date.parse(params[:start_date]) if params[:start_date]
    @end_date = Date.parse(params[:end_date]) if params[:end_date]
    @all_transactions = @all_transactions.range(@start_date, @end_date)
    @transactions = @all_transactions.joins(:account).for_user(current_user).page(params[:page])
    @total = @rule.transactions.sum(:amount)
  end

  private

  def populate_similar_transactions
    @transactions = Transaction.joins(:account).unclassified.for_user(current_user).order(:description).limit(10)
  end

  def create_params
    params.require(:rule).permit(:id, :regex, :classification_id, :user_id)
  end

  def update_params
    create_params
  end
end
