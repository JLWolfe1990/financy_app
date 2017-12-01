class ChangeClassificationsGroupToInteger < ActiveRecord::Migration[5.1]
  def up
    remove_column(:classifications, :group)
    add_column(:classifications, :group, :integer)
  end

  def down
    remove_column(:classifications, :group)
    add_column(:classifications, :group, :string)
  end
end
