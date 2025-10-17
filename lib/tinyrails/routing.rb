# frozen_string_literal: true

module Tinyrails
  class Application
    def get_controller_and_action(env)
      _, controller, action, = env['PATH_INFO'].split('/', 4)

      controller = controller.capitalize
      controller += 'Controller'

      [Object.const_get(controller), action]
    end
  end
end
