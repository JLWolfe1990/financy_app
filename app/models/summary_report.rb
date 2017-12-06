class SummaryReport < Report
  def run!
    @report = {}

    transactions.group_by(&:classification)
  end
end