require "marathon_stream/strategies"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider MarathonStream::Strategies::Developer if Rails.env.development?
  provider MarathonStream::Strategies::Twitch,
           ENV.fetch("TWITCH_CLIENT_ID", nil),
           ENV.fetch("TWITCH_CLIENT_SECRET", nil)
end
