module Tinyrails
  class View
  def initialize(env)
    @env = env
  end

  attr_accessor :env
  end
end