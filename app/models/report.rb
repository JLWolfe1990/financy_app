class Report < ApplicationRecord
  acts_as_tenant

  belongs_to :user

  def transactions
    Transaction.range(start_at, end_at)
  end
end