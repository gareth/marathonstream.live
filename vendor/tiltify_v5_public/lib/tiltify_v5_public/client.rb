# frozen_string_literal: true

module TiltifyV5Public
  class Client
    attr_reader :configuration, :connection

    def initialize(base_url: nil, **options, &block)
      @configuration = Configuration.new(base_url: base_url, **options, &block)
      @connection = Connection.new(@configuration)
    end

    def api
      @api ||= TiltifyV5Public::Api::Api.new(@connection)
    end

    def oauth
      @oauth ||= TiltifyV5Public::Api::Oauth.new(@connection)
    end
  end
end
