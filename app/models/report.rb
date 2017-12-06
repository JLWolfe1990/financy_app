class Report < ApplicationRecord
  belongs_to :user

  def transactions
    Transaction.range(start_at, end_at)
  end
end