class ChannelConstraint
  def matches?(request)
    request.subdomain.present?
  end
end

Rails.application.routes.draw do
  constraints(ChannelConstraint.new) do
    root to: "streams#index"
    resources :streams
  end
end
