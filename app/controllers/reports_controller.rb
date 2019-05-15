class ReportsController < ApplicationController
  def new
    @report = Report.new
    @report_types = [
      RuleReport,
      ClassificationReport,
      TransactionReport,
      FixedReport,
      RecurringReport,
      FixedReport
    ]
  end

  def create
    @report = Report.create report_params
    redirect_to report_path(@report)
  end

  def show
    @report = Report.find(params.fetch(:id))
    @report.run!
    @transactions = @report.transactions.page(params[:page]).per(25)
    @sum = @report.transactions.sum(:amount)

    render "reports/#{@report.type.to_s.underscore.downcase}"
  end

  private

  def report_params
    params.require(:report).permit(:start_at, :end_at, :user_id, :type)
  end
end