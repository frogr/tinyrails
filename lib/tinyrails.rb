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

      if _env['REQUEST_METHOD'] == "POST"
        klass, id, act = post_controller_and_action(_env)
        _env['route.id'] = id
      else
        klass, act = get_controller_and_action(_env)
      end

      controller = klass.new(_env)
      text = controller.send(act)
      [200, { 'content-type' => 'text/html' }, [text]]
    rescue NameError => e
      [404, { 'content-type' => 'text/html' }, ["Controller error: #{e.message}"]]
    rescue NoMethodError => e
      [404, { 'content-type' => 'text/html' }, ["Action error: #{e.message}"]]
    rescue StandardError => e
      [500, { 'content-type' => 'text/html' }, ["Internal server error: #{e.message}"]]
    end

    def self.root_dir
      __dir__
    end
  end

  class Error < StandardError; end
  # Your code goes here...
end
