class CreateTwitchChannels < ActiveRecord::Migration[7.0]
  def change
    create_table :twitch_channels do |t|
      t.string :twitch_id
      t.string :username
      t.string :display_name

      t.timestamps
    end
    add_index :twitch_channels, :twitch_id, unique: true
    add_index :twitch_channels, :username, unique: true
  end
end
