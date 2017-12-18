class MoveDataToTenant < ActiveRecord::Migration[5.1]
  def up
    t_id = Tenant.first.id

    Report.unscoped.update_all tenant_id: t_id
    Account.unscoped.update_all tenant_id: t_id
    Rule.unscoped.update_all tenant_id: t_id
    Authorization.unscoped.update_all tenant_id: t_id
    Member.unscoped.update_all tenant_id: t_id
    Transaction.unscoped.update_all tenant_id: t_id
    Classification.unscoped.update_all tenant_id: t_id
  end

  def down
    t_id = nil

    Report.unscoped.update_all tenant_id: t_id
    Account.unscoped.update_all tenant_id: t_id
    Rule.unscoped.update_all tenant_id: t_id
    Authorization.unscoped.update_all tenant_id: t_id
    Member.unscoped.update_all tenant_id: t_id
    Transaction.unscoped.update_all tenant_id: t_id
    Classification.unscoped.update_all tenant_id: t_id
  end
end
