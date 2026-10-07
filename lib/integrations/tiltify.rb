require "tiltify_v5_public"

module Integrations
  class Tiltify
    def self.client
      new(
        ENV.fetch("TILTIFY_CLIENT_ID", nil),
        ENV.fetch("TILTIFY_CLIENT_SECRET", nil)
      )
    end

    def initialize(client_id, client_secret)
      @client_id = client_id
      @client_secret = client_secret
    end

    def team(slug)
      api.public_teams_by_slug(slug: slug).data.data
    end

    def team_members(team)
      api.public_teams_members(team_id: team.id).data.data
    end

    private

    def common_configuration
      {
        base_url: "https://v5api.tiltify.com/",
        logger: Rails.logger,
        debugging: false
      }
    end

    def oauth_connection
      configuration = TiltifyV5Public::Configuration.new(**common_configuration)
      TiltifyV5Public::Connection.new(configuration)
    end

    def oauth_api
      TiltifyV5Public::Api::Oauth.new(oauth_connection)
    end

    def oauth_token
      # The token contains an ["expires_in"] field indicating its lifetime in seconds
      # Cache this token and memoize it until that expiration time (with a 30 second buffer)

      return @oauth_token if @oauth_token && Time.now.to_i < @oauth_token_expires_at - 30

      @oauth_token = oauth_api.token(client_id: @client_id, client_secret: @client_secret,
                                     grant_type: "client_credentials")
      @oauth_token_expires_at = Time.now.to_i + @oauth_token["expires_in"]
      @oauth_token
    end

    def access_token
      oauth_token["access_token"]
    end

    def configuration
      TiltifyV5Public::Configuration.new(
        **common_configuration,
        access_token: access_token
      )
    end

    def api
      TiltifyV5Public::Api::Api.new(TiltifyV5Public::Connection.new(configuration))
    end
  end
end
