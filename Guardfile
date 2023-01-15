# Basic test environment variables
minitest_env = { TEST_FORMAT: "plain" }

# Disable Pry *only if* we're running guard through our Procfile. Inside of
# foreman, because there are multiple processes being managed, Pry doesn't
# behave correctly. However, running guard standalone should still allow Pry to
# run properly.
#
# Note we can't disable Pry directly from the Procfile ENV because Guard itself
# requires Pry to be running.
minitest_env[:DISABLE_PRY] = true if ENV.key?("VIA_FOREMAN")

guard :minitest, all_on_start: false, env: minitest_env do
  watch(%r{^app/(.+)\.rb$})                               { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^app/controllers/application_controller\.rb$}) { "test/controllers" }
  watch(%r{^app/controllers/(.+)_controller\.rb$})        { |m| "test/integration/#{m[1]}_test.rb" }
  watch(%r{^app/views/(.+)_mailer/.+})                    { |m| "test/mailers/#{m[1]}_mailer_test.rb" }
  watch(%r{^lib/(.+)\.rb$})                               { |m| "test/lib/#{m[1]}_test.rb" }
  watch(%r{^test/.+_test\.rb$})
  watch(%r{^test/test_helper\.rb$}) { "test" }
end
