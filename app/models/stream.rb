class Stream < ApplicationRecord
  belongs_to :twitch_channel, class_name: "Twitch::Channel"

  validates :title, presence: true
end
