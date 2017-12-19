class AddTenantIdToAllModels < ActiveRecord::Migration[5.1]
  def change
    add_reference :accounts, :tenant
    add_reference :authorizations, :tenant
    add_reference :classifications, :tenant
    add_reference :plaid_institutions, :tenant
    add_reference :reports, :tenant
    add_reference :rules, :tenant
    add_reference :transactions, :tenant
  end
end
