module Twitch
  class Channel < ApplicationRecord
    has_many :streams, foreign_key: :twitch_channel_id

    delegate :to_param, to: :username
    delegate :to_s, to: :display_name
  end
end
