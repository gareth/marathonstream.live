module Twitch
  class Channel < ApplicationRecord
    has_many :streams, foreign_key: :twitch_channel_id
  end
end
