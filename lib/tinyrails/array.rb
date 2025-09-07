# frozen_string_literal: true

class Array
  def deeply_empty?
    empty || all?(&:empty?)
  end
end
