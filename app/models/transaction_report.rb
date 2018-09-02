class TransactionReport < Report
  validates :start_at, :end_at, presence: true
  def run!
  end

  def transactions
    Transaction.range(start_at, end_at).focus
  end
end