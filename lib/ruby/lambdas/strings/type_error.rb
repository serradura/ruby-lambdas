module Strings
  class TypeError < ::TypeError
    def initialize(data)
      super("#{data.inspect} must be a String")
    end
  end
end
