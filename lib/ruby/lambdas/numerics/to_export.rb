module RubyLambdas
  module Numerics
    module ToExport
      #
      # Operators
      #
      Add = -> (a, b) { Numeric!(a) + Numeric!(b) }

      Divide = -> (b, a) { Numeric!(a) / Numeric!(b) }

      Subtract = -> (b, a) { Numeric!(a) - Numeric!(b) }

      Multiply = -> (a, b) { Numeric!(a) * Numeric!(b) }

      #
      # Comparables
      #
      GreaterThan = -> (b, a) { Numeric!(a) > Numeric!(b) }

      GreaterThanOrEqual = -> (b, a) { Numeric!(a) >= Numeric!(b) }

      LessThan = -> (b, a) { Numeric!(a) < Numeric!(b) }

      LessThanOrEqual = -> (b, a) { Numeric!(a) <= Numeric!(b) }
    end

    ALIASES = {
      GreaterThan: :Gt,
      GreaterThanOrEqual: :Gte,
      LessThan: :Lt,
      LessThanOrEqual: :Lte,
    }.freeze
  end
end
