class AddColumnArchivedToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :archived, :boolean
  end
end
