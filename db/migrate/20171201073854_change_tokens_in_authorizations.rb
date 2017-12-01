class ChangeTokensInAuthorizations < ActiveRecord::Migration[5.1]
  def change
    rename_column(:authorizations, :token, :public_token)
    add_column(:authorizations, :access_token, :string)
  end
end
