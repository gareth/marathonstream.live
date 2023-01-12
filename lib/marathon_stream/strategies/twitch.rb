require "omniauth-oauth2"

module MarathonStream
  module Strategies
    class Twitch < OmniAuth::Strategies::Twitch
      def authorize_params
        # Customize scope management
        #
        # OmniAuth::Strategies::Twitch defaults scopes to user:read:email and
        # doesn't appear to give a great way to override this - particularly if
        # you want *no* scope (which we do by default).
        super.tap do |params|
          params.delete(:scope)
        end
      end
    end
  end
end
