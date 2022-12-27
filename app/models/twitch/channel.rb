module Twitch
  class Channel < ApplicationRecord
    has_many :streams, foreign_key: :twitch_channel_id

    def to_param
      twitch_username.to_param
    end
  end
end
