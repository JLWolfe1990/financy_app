class AddRecurringAndFixedToRules < ActiveRecord::Migration[5.1]
  def change
    add_column :rules, :recurring, :boolean
    add_column :rules, :fixed, :boolean
  end
end
