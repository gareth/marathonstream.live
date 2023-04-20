class AddSyncModeratorsOptionToTwitchChannels < ActiveRecord::Migration[7.0]
  def change
    add_column :twitch_channels, :sync_moderators, :boolean, default: false, null: false
  end
end
