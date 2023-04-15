require "omniauth-oauth2"

module MarathonStream
  module Strategies
    class Twitch < OmniAuth::Strategies::Twitch
      # By default, ask for no scopes (The omniauth-twitch default is
      # user:read:email)
      option :scope, ""

      def authorize_params
        # By default, omniauth-oauth2 lets you set a single scope that your
        # application will ask for. You can also pass a `scope` parameter to the
        # `/auth/:provider` action that will be passed on to the request.
        #
        # However, we want to request scopes that are a) sometimes dependent on
        # the user making the request (e.g. different scopes for broadcasters to
        # viewers) and b) not in the user's control.
        #
        # To do that, we have to override `authorize_params`. It's possible to
        # pass a lambda to the `scope` config option, but the lambda doesn't
        # have access to the application session (which we use to get the
        # current user), so this approach works better.
        super.tap do |params|
          target_scopes = Set.new

          if (user = ::Twitch::User.find_by(uid: session.dig("identity.data", "uid")))
            target_scopes += user.token_scopes
          end

          params[:scope] = target_scopes.join(" ").presence
        end
      end

      # When you make an OAuth login request to a server, you ask for a list of
      # scopes that the returned token should have access to. To complete the
      # login, the server has to give you the approved access/refresh token.
      #
      # However the OAuth specification says that the OAuth server MAY also
      # return the list of scopes that the token *actually* has access to. The
      # Twitch OAuth API supports this behaviour and does return the approved
      # scopes.
      #
      # The OAuth2 gem explicitly exposes the access/refresh token details as
      # part of its access token API, and the omniauth-oauth2 gem includes those
      # details in the credentials hash. However, neither gem explicitly
      # supports the returned `scope` parameter, so we have to add support for
      # it here.
      #
      # The omniauth-oauth2 gem assumes you remember and use the list of scopes
      # that you _asked_ for if you need to store that information. However here
      # we prefer to confirm the verified list of scopes that the token has
      # access to.
      credentials do
        hash = {}
        hash["scope"] = access_token[:scope] if access_token.params.key?(:scope)
        hash
      end
    end
  end
end
