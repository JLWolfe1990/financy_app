class AddExcludedToClassifications < ActiveRecord::Migration[5.1]
  def change
    add_column :classifications, :excluded, :bool
  end
end
