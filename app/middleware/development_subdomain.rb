# Use a querystring parameter to override `request.host` in development and
# persist that choice in the session until reset
class DevelopmentSubdomain
  SUBDOMAIN_PARAM = :_sudo
  SUBDOMAIN_KEY = :development_subdomain
  PLACEHOLDER_DOMAIN = "marathonstream.example".freeze

  def initialize(app)
    @app = app
  end

  def call(env)
    request = ActionDispatch::Request.new(env)
    session = request.session

    if request.params.key?(SUBDOMAIN_PARAM)
      detected_subdomain = if (requested_subdomain = request.params[SUBDOMAIN_PARAM].presence)
        # Parse the parameter to make sure it's a valid subdomain
        begin
          URI("//#{requested_subdomain}").host.split(".").first.tap do |subdomain|
            Rails.logger.debug format("Detected requested subdomain: %s", subdomain)
          end
        rescue URI::InvalidURIError => e
          Rails.logger.warn "Invalid subdomain detected: #{e}"
          Rails.logger.info "Returning to previous subdomain"
          session[SUBDOMAIN_KEY]
        end
      end
      session[SUBDOMAIN_KEY] = detected_subdomain
    end

    if session[SUBDOMAIN_KEY]
      Rails.logger.info format("Using overridden subdomain: %s", session[SUBDOMAIN_KEY])
      env["HTTP_HOST"] = "#{session[SUBDOMAIN_KEY]}.#{PLACEHOLDER_DOMAIN}"
    end

    @app.call(env)
  end
end
