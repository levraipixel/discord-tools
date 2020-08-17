class AddDiscordDataToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :avatar_url, :string
    add_column :users, :name, :string
    add_column :users, :discord_username, :string
    add_column :users, :discord_discriminator, :string
    add_column :users, :discord_token, :string
    add_column :users, :discord_refresh_token, :string
    add_column :users, :discord_token_expires, :boolean
    add_column :users, :discord_token_expires_at, :integer
  end
end
