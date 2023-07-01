class AddActivationTokenExpiresAtToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :reset_token_expires_at, :datetime
    add_column :users, :activation_token_expires_at, :datetime
    add_column :users, :reset_token, :string
  end
end
