# frozen_string_literal: true

require_relative 'tinyrails/version'
require_relative 'tinyrails/array'

module Tinyrails
  class Application
    def call(_env)
      [200, { 'Content-Type' => 'text/html' }, ['Hello from Tinyrails!']]
    end
  end

  class Error < StandardError; end
  # Your code goes here...
end
