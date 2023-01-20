class BroadcasterNavigation
  attr_reader :session, :helpers
  alias h helpers

  def initialize(helpers)
    @helpers = helpers
  end

  def present?
    links.present?
  end

  def empty?
    !present?
  end

  def links
    [
      link(:index, Stream, "Streams", h.streams_url)
    ].compact
  end

  def link(action, target, text, destination)
    return unless h.policy(target).send("#{action}?")

    h.link_to text, destination
  end
end
