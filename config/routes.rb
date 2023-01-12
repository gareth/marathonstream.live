class ChannelConstraint
  def matches?(request)
    subdomain = Channelable.subdomain(request)
    subdomain.present? && subdomain != "www"
  end
end

class NoChannelConstraint
  def matches?(request)
    !ChannelConstraint.new.matches?(request)
  end
end

Rails.application.routes.draw do
  match "/auth/:provider/callback", to: "sessions#create", via: %i[get post]
  resource :session

  constraints(ChannelConstraint.new) do
    root to: "streams#index", as: :channel_root

    resources :streams
  end

  constraints(NoChannelConstraint.new) do
    root to: "pages#home"
  end
end
