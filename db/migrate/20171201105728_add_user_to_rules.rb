class AddUserToRules < ActiveRecord::Migration[5.1]
  def change
    add_reference :rules, :user, foreign_key: true
  end
end
