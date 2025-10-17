# frozen_string_literal: true

module Tinyrails
  def self.to_underscore(string)
    string.gsub(/::/, '/')
          .gsub(/([A-Z]+)([A-Z])([a-z])/, '\1_\2\3')
          .gsub(/([a-z\d])([A-Z])/, '\1_\2')
          .tr('-', '_')
          .downcase
  end
end
