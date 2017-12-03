class RulesController < ApplicationController
  before_action :populate_similar_transactions, only: [:new, :create]

  def index
    @rules = Rule.all
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

  def update
  end

  def apply
  end

  def show
    @rule = Rule.find(params.fetch(:id))
    @transactions = @rule.transactions.joins(:account).for_user(current_user).page(params[:page])
    @total = @rule.transactions.sum(:amount)
  end

  private

  def populate_similar_transactions
    @transactions = Transaction.joins(:account).unclassified.for_user(current_user).order(:description).limit(10)
  end

  def create_params
    params.require(:rule).permit(:id, :regex, :classification_id, :user_id)
  end
end
