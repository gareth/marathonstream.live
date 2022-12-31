require "httparty"

module Nanoleaf
  class API
    include HTTParty
    # debug_output

    BASE_PATH = Pathname.new("/api/v1").freeze

    attr_reader :host, :port, :token

    def initialize(host:, port:, token:)
      @host = host
      @port = port
      @token = token
    end

    def state
      get("")
    end

    def state=(state)
      color_mode = state.dig("state", "colorMode")
      case color_mode
      when "hs"
        hsb!(
          state.dig("state", "hue", "value"),
          state.dig("state", "sat", "value"),
          state.dig("state", "brightness", "value")
        )
      when "effect"
        effect! state.dig("effects", "select")
      else
        raise "Unknown colorMode: #{color_mode}"
      end
      brightness! state.dig("state", "brightness", "value")
      on! state.dig("state", "on", "value")
    end

    def on!(value)
      put("state", { on: { value: } })
    end

    def off!
      on! false
    end

    def effect!(name)
      put("effects", { select: name })
    end

    def red!
      hsb! 0, 100, 100
    end

    def green!
      hsb! 120, 100, 100
    end

    def hsb!(hue, sat, bri, duration = 0)
      put "state", {
        hue: { value: hue },
        sat: { value: sat },
        brightness: { value: bri, duration: }
      }
    end

    def hue!(value, _duration = 0)
      put "state", { hue: { value: } }
    end

    def sat!(value, _duration = 0)
      put "state", { sat: { value: } }
    end

    def brightness!(value, duration = 0)
      put "state", { brightness: { value:, duration: } }
    end

    def get(endpoint)
      parse_response do
        API.get(endpoint_url(endpoint)).body
      end
    end

    def post(endpoint, data = nil)
      parse_response do
        API.post(endpoint_url(endpoint), body: data.to_json, headers: { "Content-Type" => "application/json" }).body
      end
    end

    def put(endpoint, data = nil)
      parse_response do
        API.put(endpoint_url(endpoint), body: data.to_json, headers: { "Content-Type" => "application/json" }).body
      end
    end

    def endpoint_url(endpoint)
      path = BASE_PATH.join(token).join(endpoint).to_s
      URI::HTTP.build(host:, port:, path:)
    end

    def parse_response
      response = yield
      begin
        JSON.parse(response)
      rescue StandardError
        response
      end
    end
  end
end
