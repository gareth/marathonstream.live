# Use a querystring parameter to override `request.host` in development and
# persist that choice in the session until reset
class DevelopmentSubdomain
  SUBDOMAIN_PARAM = :_sudo
  SUBDOMAIN_SESSION_KEY = :development_subdomain
  ENV_KEY = "marathonstream.subdomain".freeze

  attr_reader :request

  def initialize(app)
    @app = app
  end

  def call(env)
    @request = ActionDispatch::Request.new(env)
    handle_subdomain_request!(env) if local_request?

    @app.call(env)
  end

  def local_request?
    request.host == "localhost"
  end

  # Populate ENV with either the subdomain from the query string, or a
  # previously stored subdomain from the session.
  def handle_subdomain_request!(env)
    session = request.session

    session[SUBDOMAIN_SESSION_KEY] = new_subdomain if request.params.key?(SUBDOMAIN_PARAM)

    env[ENV_KEY] = session[SUBDOMAIN_SESSION_KEY]
  end

  def requested_subdomain?
    request.params.key?(SUBDOMAIN_PARAM)
  end

  def new_subdomain
    requested_subdomain = request.params[SUBDOMAIN_PARAM].presence

    # If the key is present but the value is blank, we're unsetting the current subdomain
    return unless requested_subdomain

    # Parse the parameter to make sure it's a valid subdomain
    URI("//#{requested_subdomain}").host.split(".").first.tap do |subdomain|
      Rails.logger.debug format("Detected requested subdomain: %s", subdomain)
    end
  rescue URI::InvalidURIError => e
    Rails.logger.warn "Invalid subdomain detected: #{e}"
    Rails.logger.info "Returning to previous subdomain"
    session[SUBDOMAIN_SESSION_KEY]
  end
end
