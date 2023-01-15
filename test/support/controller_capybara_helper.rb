# A set of helper methods that allow Capybara finders and assertions to be used
# inside controller tests.
#
# Controller tests aren't designed to be used for testing user flows (`click`,
# `fill_in` etc) but it *is* valid to check for page content inside them
# (Rails::Dom::Testing includes assertions to do this inside controller tests)
#
# By processing `response.body` as a [`Capybara::Node::Simple`][1] ([thanks
# thoughtbot][2]) we get the ability to run Capybara finders and assertions on
# the returned HTML, without needing a full Capybara session.
#
# And by emulating scopes and the `within` helper, we get the flexibility of
# scoped assertions.
#
# [1]: https://www.rubydoc.info/gems/capybara/Capybara/Node/Simple
# [2]: https://thoughtbot.com/blog/use-capybara-on-any-html-fragment-or-page
module ControllerCapybaraHelper
  extend ActiveSupport::Concern

  def page_scopes
    @page_scopes ||= [nil]
  end

  def current_scope
    scope = page_scopes.last
    scope.nil? ? document : scope
  end

  def document
    @document ||= Capybara.string response.body
  end

  def page
    current_scope
  end

  def within(*args, **kw_args, &)
    new_scope = page.find(*args, **kw_args)
    begin
      page_scopes.push(new_scope)
      yield new_scope if block_given?
    ensure
      page_scopes.pop
    end
  end
end

ActionDispatch::IntegrationTest.include ControllerCapybaraHelper
