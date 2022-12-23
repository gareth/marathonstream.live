Twitch::Channel.find_or_create_by!(twitch_username: "helix") do |c|
  c.twitch_id = 42
  c.twitch_display_name = "HeliX"
end
