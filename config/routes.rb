class ChannelConstraint
  def matches?(request)
    subdomain = Channelable.subdomain(request)
    subdomain.present? && subdomain != "www"
  end
end

class NoChannelConstraint # rubocop:disable Style/OneClassPerFile
  def matches?(request)
    !ChannelConstraint.new.matches?(request)
  end
end

Rails.application.routes.draw do
  channel_routes = lambda do
    get "/", to: "channels#show"

    resource :channel
    resources :streams
  end

  match "/auth/:provider/callback", to: "sessions#create", via: %i[get post]
  resource :session

  scope("/~:channel_name", &channel_routes)

  constraints(ChannelConstraint.new, &channel_routes)

  constraints(NoChannelConstraint.new) do
    root to: "pages#home"
  end
end
