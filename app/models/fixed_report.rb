class FixedReport < RuleReport
  def transactions
    Transaction.range(start_at, end_at).joins(:rule).where(rules: {fixed: true})
  end
end