# frozen_string_literal: true

require_relative 'tinyrails/version'
require_relative 'tinyrails/routing'
require_relative 'tinyrails/array'
require_relative 'tinyrails/dependencies'
require_relative 'tinyrails/util'
require_relative 'tinyrails/controller'
require_relative 'tinyrails/file_model'

module Tinyrails
  class Application
    def call(_env)
      return [404, { 'content-type' => 'text/html' }, []] if _env['PATH_INFO'] == '/favicon.ico'

      if _env['PATH_INFO'] == '/'
        return [302, { 'location' => '/tweets/a_tweet' }, ['<html><body>Redirecting...</body></html>']]
      end

      klass, id, act = get_controller_and_action(_env)
      _env['route.id'] = id if id

      controller = klass.new(_env)
      result = controller.send(act)

      if result.is_a?(Array) && result.length == 3 && result[0].is_a?(Integer)
        result
      else
        [200, { 'content-type' => 'text/html' }, [result]]
      end

    rescue NameError => e
      no_controller_error(e)
    rescue NoMethodError => e
      no_action_error(e)
    rescue StandardError => e
      internal_server_error(e)
    end

    def no_controller_error(e)
      [404, { 'content-type' => 'text/html' }, ["Controller error: #{e.message}"]]
    end

    def no_action_error(e)
      [404, { 'content-type' => 'text/html' }, ["Action error: #{e.message}"]]
    end

    def internal_server_error(e)
      [500, { 'content-type' => 'text/html' }, ["Internal server error: #{e.message}"]]
    end

    def self.root_dir
      __dir__
    end
  end

  class Error < StandardError; end
  # Your code goes here...
end
