class FixedReport < RuleReport
  def transactions
    super.where(fixed: true)
  end
end