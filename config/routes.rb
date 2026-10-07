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

def channel_routes(prefix)
  lambda do
    get "/", to: "channels#show", as: :"#{prefix}_root"

    resource :channel
    resources :streams
  end
end

Rails.application.routes.draw do
  match "/auth/:provider/callback", to: "sessions#create", via: %i[get post]
  resource :session

  scope("/~:channel_name", &channel_routes(:path))

  constraints(ChannelConstraint.new, &channel_routes(:subdomain))

  constraints(NoChannelConstraint.new) do
    root to: "pages#home"
  end
end
