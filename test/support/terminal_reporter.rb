require "minitest/reporters"
require "os"
require "terminal-notifier"

class TerminalReporter < Minitest::Reporters::BaseReporter
  def report
    super
    # binding.pry
    show_notification if OS.mac?
  end

  private

  def show_notification
    status = (passed? ? "\u{1F49A} Success" : "\u{1F494} Failed")
    title = "Minitest #{status}"
    group = "minitest"

    if passed?
      # Hiding successful notifications because we have Nanoleaf flashing for that.
      # Having these reporters coupled together isn't great, but :shrug:
      msg = "%<total_count>i tests (%<skips>i skips) in %<total_time>0.3fs"
      subtitle = format(msg, total_count:, skips:, total_time:)
      text = "Congratulations!"
      TerminalNotifier.notify(text, subtitle:, title:, group:)
    else
      msg = "%<failures>i/%<total_count>i tests (%<skips>i skips) in %<total_time>0.3fs"
      subtitle = format(msg, failures: failures + errors, total_count:, skips:, total_time:)
      text = first_failure
      TerminalNotifier.notify(text, title:, subtitle:, group:)
    end
  end

  def first_failure
    failure = tests.detect { |t| !t.skipped? && t.failures.any? }

    test_name = failure.name.gsub(/^test_\d+_/, "")

    format("%<klass>s %<test>s", klass: failure.klass, test: test_name)
  end
end
