class FetchTransactionsJob < ApplicationJob
queue_as :default

  def perform(t_id, auth_id)
    Tenant.set_current_tenant t_id

    Authorization.find(auth_id).tap do |auth|
      begin
        auth.accounts.active.find_each do |account|
          account.fetch_transactions!
        end
      rescue Exception => e
        Rails.logger.error e.message
        Rails.logger.error e.backtrace.join('/n')
      end
    end

    Rule.apply_all
  end
end
