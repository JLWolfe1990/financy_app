class RecurringReport < RuleReport
  def transactions
    Transaction.range(start_at, end_at).joins(:rule).where(rules: {recurring: true})
  end
end