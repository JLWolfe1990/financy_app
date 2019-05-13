require 'rails_helper'

RSpec.describe Account, type: :model do
  let! :tenant do
    Tenant.create!
  end

  let! :account do
    create(:account)
  end

  let! :archived_account do
    create(:account, :archived)
  end

  context 'scopes' do
    context 'archived' do
      it 'should only return archived accounts' do
        expect(Account.archived).to eq(archived_account)
      end
    end

    context 'active' do
      it 'should only return active accounts' do
        expect(Account.active).to eq(active)
      end
    end
  end
end
