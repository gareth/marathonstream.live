module ApplicationHelper
  def broadcaster_navigation
    @broadcaster_navigation ||=
      BroadcasterNavigation.new(self)
  end
end
