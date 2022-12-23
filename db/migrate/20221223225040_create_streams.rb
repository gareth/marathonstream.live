class CreateStreams < ActiveRecord::Migration[7.0]
  def change
    create_table :streams do |t|
      t.references :twitch_channel, null: false, foreign_key: true
      t.datetime :starts_at
      t.integer :initial_duration

      t.timestamps
    end
  end
end
