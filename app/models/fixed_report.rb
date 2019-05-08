class FixedReport < RuleReport
  def transactions
    super.joins(:rule).where(rules:{fixed: true})
  end
end