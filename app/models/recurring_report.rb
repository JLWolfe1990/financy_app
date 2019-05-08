class RecurringReport < RuleReport
  def transactions
    super.joins(:rule).where(rules:{recurring: true})
  end
end