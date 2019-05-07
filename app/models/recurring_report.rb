class RecurringReport < RuleReport
  def transactions
    super.where(recurring: true)
  end
end