module MarathonStream
  module Strategies
    class Developer
      include OmniAuth::Strategy

      CONFIGURABLE_ATTRS = %i[
        request_forgery_protection_token forgery_protection_strategy
        allow_forgery_protection log_warning_on_csrf_failure forgery_protection_origin_check
        per_form_csrf_tokens csrf_token_storage_strategy
      ].freeze

      Configuration = Struct.new(*CONFIGURABLE_ATTRS)

      class << self
        def config
          @config ||= Configuration.new
        end

        def configurable(name)
          define_singleton_method(name) do
            config[name]
          end

          define_singleton_method("#{name}=") do |value|
            config[name] = value
          end
        end
      end

      CONFIGURABLE_ATTRS.each do |attr|
        configurable attr
      end

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
