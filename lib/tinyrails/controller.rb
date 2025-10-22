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

    def render_to_string(view_name, locals = {})
      filename = File.join 'app', 'views', controller_name, "#{view_name}.html.erb"
      template = File.read filename
      eruby = Erubis::Eruby.new(template)
      eruby.result locals.merge(env: env)
    end

    def response(text, status=200, headers={})
      raise "Already responded!" if response

      a = [text].flatten
      @response = Rack::Response.new(a, status, headers)
    end

    def get_response
      @response
    end

    def render(view_name, locals={})
      controller_vars = {}
      instance_variables.each do |var|
        next if var == :@env || var == :@request || var == :@response
        key = var.to_s.gsub('@',  '').to_sym
        controller_vars[key] = instance_Variable_get(var)
      end

      response(render_to_string(view_name), locals.merge(controller_vars))
    end

    def request
      @request ||= Rack::Request.new(@env)
    end

    def params
      request.params
    end
  end
end
