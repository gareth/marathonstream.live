require "omniauth-oauth2"

module MarathonStream
  module Strategies
    class Twitch < OmniAuth::Strategies::Twitch
      # By default, ask for no scopes (The omniauth-twitch default is
      # user:read:email)
      option :scope, ""
    end
  end
end
