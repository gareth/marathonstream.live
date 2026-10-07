require "twitchrb"

module Integrations
  class Twitch
    attr_reader :_client

    def self.client
      new(ENV.fetch("TWITCH_CLIENT_ID", nil), ENV.fetch("TWITCH_CLIENT_SECRET", nil))
    end

    def initialize(client_id, client_secret)
      @client_id = client_id
      @client_secret = client_secret
    end

    def app_client
      oauth = ::Twitch::OAuth.new(client_id: @client_id, client_secret: @client_secret)
      token = oauth.create(grant_type: "client_credentials")

      ::Twitch::Client.new(client_id: @client_id, access_token: token.access_token)
    end

    def user_client(twitch_user)
      ::Twitch::Client.new(client_id: @client_id, access_token: twitch_user.token)
    end
  end
end
