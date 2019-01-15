module Numerics
  class TypeError < ::TypeError
    def initialize(data)
      super("#{data.inspect} must be Numeric")
    end
  end
end
