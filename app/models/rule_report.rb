class RuleReport < Report
  attr_accessor :transaction_groups, :transaction_totals

  def run!
    @transaction_groups = transactions.group_by(&:rule)

    @transaction_totals = {}
    transaction_groups.each do |k, v|
      @transaction_totals[k] = v.inject(0) {|memo, val| memo + val.amount}
    end
  end
end