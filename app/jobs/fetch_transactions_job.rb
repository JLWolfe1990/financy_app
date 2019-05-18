class FetchTransactionsJob < ApplicationJob
queue_as :default

  def perform(t_id, auth_id)
    Tenant.set_current_tenant t_id

    Authorization.find(auth_id).tap do |auth|
      auth.accounts.active.find_each do |account|
        account.fetch_transactions!
      end
    end
  end
end
