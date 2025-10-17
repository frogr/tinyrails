# frozen_string_literal: true

module Tinyrails
  class Application
    def get_controller_and_action(env)
      _, controller, second, third = env['PATH_INFO'].split('/', 4)
      if env['REQUEST_METHOD'] == 'POST'
        [controller_name(controller), second, third]
      else
        [controller_name(controller), nil, second]
      end
    end

    def controller_name(controller)
      "#{controller.capitalize}Controller"
    end
  end
end
