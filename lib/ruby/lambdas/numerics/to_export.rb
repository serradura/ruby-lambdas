module RubyLambdas
  module Numerics
    module ToExport
      #
      # Operators
      #
      Add = -> (a, b) { a + b }

      Divide = -> (b, a) { a / b }

      Subtract = -> (b, a) { a - b }

      Multiply = -> (a, b) { a * b }

      #
      # Comparables
      #
      GreaterThan = -> (b, a) { a > b }

      GreaterThanOrEqual = -> (b, a) { a >= b }

      LessThan = -> (b, a) { a < b }

      LessThanOrEqual = -> (b, a) { a <= b }
    end

    ALIASES = {
      GreaterThan: :Gt,
      GreaterThanOrEqual: :Gte,
      LessThan: :Lt,
      LessThanOrEqual: :Lte,
    }.freeze
  end
end
