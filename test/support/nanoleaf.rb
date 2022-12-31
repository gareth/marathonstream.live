require "dnssd"

require_relative "nanoleaf/api"

module Nanoleaf
  NoUniqueServiceError = Class.new(StandardError)

  SERVICE_TYPE = "_nanoleafapi._tcp".freeze
  TIMEOUT = 1

  def self.discover
    replies = []

    # Manually call `DNSSD::Service.browse` rather than using the convenience
    # method `DNSSD.browse` because that method offers no way to set a timeout.
    begin
      service = DNSSD::Service.browse SERVICE_TYPE
      service.each(TIMEOUT) do |reply|
        replies << reply
        break unless reply.flags.more_coming?
      end
    ensure
      service.stop
    end

    # If we already just received a reply then there's less reason to worry
    # about a timeout, so we can use the convenience `resolve!` method.
    resolves = []
    replies.each do |reply|
      DNSSD.resolve!(reply) do |resolve|
        resolves << resolve
        break unless resolve.flags.more_coming?
      end
    end

    # By the end of this call we need a single service to notify. The naive
    # approach is just to fail if we're on a network without exactly one
    # service. That's good enough for the current active development.
    raise NoUniqueServiceError, "Too many services found" if resolves.many?
    raise NoUniqueServiceError, "No services found" if resolves.none?

    resolve = resolves.first
    API.new(host: resolve.target, port: resolve.port, token: ENV.fetch("NANOLEAF_TOKEN"))
  end
end
