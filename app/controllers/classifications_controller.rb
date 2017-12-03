class ClassificationsController < ApplicationController
  def index
    @classifications = Classification.all
  end

  def new
  end

  def create
  end

  def update
  end

  def show
    @classification = Classification.find(params.fetch(:id))
    @transactions = @classification.transactions.page(params[:page])
    @total = @classification.transactions.sum(:amount)
  end
end
