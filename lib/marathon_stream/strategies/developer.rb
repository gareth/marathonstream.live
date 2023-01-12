module MarathonStream
  module Strategies
    class Developer
      include OmniAuth::Strategy

      include ActiveSupport::Configurable
      include ActionController::RequestForgeryProtection

      def request_phase
        [200, { "content-type" => "text/html" }, [form]]
      end

      uid do
        :none
      end

      info do
        {
          role: request.params["role"]
        }
      end

      def form
        # TODO: Just have this form directly on the login page. No need for a request_phase here
        ActionView::Base.empty.then do |h|
          h.content_tag(:body, style: "display: grid; place-items: center") do
            h.form_tag(callback_path) do
              h.select_tag(
                :role,
                h.options_for_select(Role.values)
              ) + h.submit_tag("Login")
            end
          end
        end
      end
    end
  end
end
