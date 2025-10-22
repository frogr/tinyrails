# frozen_string_literal: true

require 'erubis'
require 'rack/request'
require_relative 'file_model'

module Tinyrails
  class Controller
    include Tinyrails::Model

    def initialize(env)
      @env = env
    end

    attr_reader :env

    def controller_name
      klass = self.class
      klass = klass.to_s.gsub(/Controller$/, '')
      Tinyrails.to_underscore klass
    end

    def render(view_name, locals = {})
      filename = File.join 'app', 'views', controller_name, "#{view_name}.html.erb"
      template = File.read filename
      eruby = Erubis::Eruby.new(template)
      eruby.result locals.merge(env: env)
    end

    def request
      @request ||= Rack::Request.new(@env)
    end

    def params
      request.params
    end
  end
end
