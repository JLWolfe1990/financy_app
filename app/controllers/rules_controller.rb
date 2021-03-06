class RulesController < ApplicationController
  before_action :populate_similar_transactions, only: [:new, :create]

  def index
    @rules = Rule.all.order(:regex).page params[:page]
  end

  def new
    @rule = Rule.new
    @left_count = Transaction.unclassified.count
  end

  def create
    @rule = Rule.new create_params

    Rule.transaction do
      if @rule.save
        @rule.apply!
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
        @rule.reapply!
        redirect_to rule_path(@rule)
      else
        render edit_rule_path(@rule)
      end
    end
  end

  def apply
  end

  def show
    @rule = Rule.find(params.fetch(:id))
    @all_transactions = @rule.transactions.active
    @start_date = Date.parse(params[:start_date]) if params[:start_date]
    @end_date = Date.parse(params[:end_date]) if params[:end_date]
    @all_transactions = @all_transactions.range(@start_date, @end_date) if @start_date && @end_date
    @transactions = @all_transactions.joins(:account).page(params[:page])
    @total = @all_transactions.sum(:amount)
  end

  def destroy
    @rule = Rule.find(params.fetch(:id))
    @rule.transaction do
      @rule.transactions.update_all(classification_id: nil)
      @rule.destroy!
    end

    redirect_to rules_path
  end

  private

  def populate_similar_transactions
    @transactions = Transaction.active.joins(:account).unclassified.order(:description).limit(10)
  end

  def create_params
    params.require(:rule).permit(:id, :regex, :classification_id, :user_id, :fixed, :recurring)
  end

  def update_params
    create_params
  end
end
