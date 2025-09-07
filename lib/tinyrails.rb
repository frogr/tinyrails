# frozen_string_literal: true

require_relative 'tinyrails/version'
require_relative 'tinyrails/routing'
require_relative 'tinyrails/array'

module Tinyrails
  class Application
    def call(_env)
      klass, act = get_controller_and_action(_env)
      controller = klass.new(_env)
      text = controller.send(act)
      [200, { 'content-type' => 'text/html' }, [text]]
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end

    def env
      @env
    end
  end

  class Error < StandardError; end
  # Your code goes here...
end
