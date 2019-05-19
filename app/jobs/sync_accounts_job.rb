class SyncAccountsJob < ApplicationJob
queue_as :default

  def perform()
    Tenant.find_each do |t|
      Tenant.set_current_tenant t
      puts "*****************************"

      Authorization.find_each do |auth|
        # auth.retreive_access_token!

        auth.accounts.active.find_each do |account|
          account.fetch_transactions!(account.transactions.last&.created_at - 7.days)
        end
      end
    end
  end
end
