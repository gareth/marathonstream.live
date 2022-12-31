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
    subtitle = "#{total_count} tests, #{failures} failures, #{errors} errors, #{skips} skips in #{total_time.round(4)}s"

    if passed?
      msg = "%<total_count>i tests (%<skips>i skips) in %<total_time>0.3fs"
      subtitle = format(msg, total_count:, skips:, total_time:)
      text = "Congratulations!"
    else
      msg = "%<failures>i/%<total_count>i tests (%<skips>i skips) in %<total_time>0.3fs"
      subtitle = format(msg, failures:, total_count:, skips:, total_time:)
      text = first_failure
    end

    group = "minitest"

    TerminalNotifier.notify(text, title:, subtitle:, group:)
  end

  def first_failure
    failure = tests.detect { |t| t.failures.any? }

    test_name = failure.name.gsub(/^test_\d+_/, "")

    format("%<klass>s %<test>s", klass: failure.klass, test: test_name)
  end
end
