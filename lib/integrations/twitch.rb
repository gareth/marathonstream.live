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

      oauth = ::Twitch::OAuth.new(client_id: @client_id, client_secret: @client_secret)
      token = oauth.create(grant_type: "client_credentials")

      @_client = ::Twitch::Client.new(client_id: @client_id, access_token: token.access_token)
    end
  end
end
