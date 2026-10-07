# frozen_string_literal: true

module TiltifyV5Public
  module Api
    class Oauth
      def initialize(connection)
        @connection = connection
      end

      def authorize(client_id:, redirect_uri:, response_type:, scope: nil)
        raise ArgumentError, 'client_id is required' if client_id.nil?
        raise ArgumentError, 'redirect_uri is required' if redirect_uri.nil?
        raise ArgumentError, 'response_type is required' if response_type.nil?

        @connection.call(
          :GET,
          '/oauth/authorize',
          type: nil,
          auth: ['authorization'],
          query: { 'client_id' => client_id, 'redirect_uri' => redirect_uri, 'response_type' => response_type, 'scope' => scope }
        )
      end

      def token(client_id:, client_secret:, grant_type:, code: nil, refresh_token: nil, scope: nil)
        raise ArgumentError, 'client_id is required' if client_id.nil?
        raise ArgumentError, 'client_secret is required' if client_secret.nil?
        raise ArgumentError, 'grant_type is required' if grant_type.nil?

        @connection.call(
          :POST,
          '/oauth/token',
          type: nil,
          auth: ['authorization'],
          form: { 'client_id' => client_id, 'client_secret' => client_secret, 'grant_type' => grant_type, 'code' => code, 'refresh_token' => refresh_token, 'scope' => scope }
        )
      end
    end
  end
end
