class Object
  def self.const_missing(c)
    begin
      require Tinyrails.to_underscore(c.to_s)
    rescue LoadError => e
      raise NameError, "#{c} was not found. Did you spell it correctly?"
    end

    if const_defined?(c)
      const_get(c)
    else
      raise NameError, "Found #{Tinyrails.to_underscore(c.to_s)}.rb, but #{c} was not defined"
    end
  end
end