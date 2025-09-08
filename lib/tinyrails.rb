# frozen_string_literal: true

require_relative 'tinyrails/version'
require_relative 'tinyrails/routing'
require_relative 'tinyrails/array'
require_relative 'tinyrails/dependencies'
require_relative 'tinyrails/util'

module Tinyrails
  class Application
    def call(_env)
      if _env['PATH_INFO'] == '/favicon.ico'
        return [404, {'content-type' => 'text/html'}, []]
      end

      if _env['PATH_INFO'] == '/'
        return [302, {'location' => '/tweets/a_tweet'}, ['<html><body>Redirecting...</body></html>']]
      end

      klass, act = get_controller_and_action(_env)
      controller = klass.new(_env)
      text = controller.send(act)
      [200, { 'content-type' => 'text/html' }, [text]]
    rescue NameError => e
      [404, {'content-type' => 'text/html'}, ["No controller registered with this name."]]
    rescue NoMethodError => e
      [404, {'content-type' => 'text/html'}, ["No action registered with this name."]]
    rescue => e
      [500, {'content-type' => 'text/html'}, ["Internal server error  "]]
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
