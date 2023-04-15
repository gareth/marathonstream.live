class CreateTwitchUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :twitch_users do |t|
      t.string :uid, null: false
      t.string :login, null: false
      t.string :display_name
      t.string :token_scopes, array: true, default: []
      t.string :token
      t.string :refresh_token
      t.datetime :token_expires_at

      t.timestamps
    end
  end
end
