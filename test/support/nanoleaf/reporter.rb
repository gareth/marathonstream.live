require "minitest/reporters"

module Nanoleaf
  class Reporter < Minitest::Reporters::BaseReporter
    def report
      super

      service = Nanoleaf.discover
      state = service.state

      # If the lights are off but reachable, don't flash them
      return unless state.dig("state", "on", "value")

      begin
        synchronize do
          print "Flashing success on Nanoleaf... "
          if passed?
            service.green!
            sleep 0.9
          else
            service.red!
            sleep 1.2
          end
          puts "Done!"
        end
      ensure
        service.state = state
      end
    rescue Nanoleaf::NoUniqueServiceError => e
      Rails.logger.debug("Unable to report to Nanoleaf: #{e}")
    end
  end
end
