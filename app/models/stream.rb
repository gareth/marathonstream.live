class Stream < ApplicationRecord
  belongs_to :twitch_channel, class_name: "Twitch::Channel"

  validates :title, presence: true

  scope :active_at,
        lambda { |ts|
          where("starts_at < ?", ts).where("extract(epoch from (? - starts_at)) < initial_duration", ts)
        }

  scope :active, -> { active_at(Time.now) }
end
