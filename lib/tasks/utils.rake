namespace :utils do
  desc "Enqueue fetch transactions"
  task :queue_fetch_transactions => :environment do
    Tenant.find_each do |t|
      Tenant.set_current_tenant t

      Authorization.find_each do |auth|
        FetchTransactionsJob.perform_later(t.id, auth.id)
      end
    end
  end
end