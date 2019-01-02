module RubyLambdas
  module Numerics
    module ToExport
      #
      # Operators
      #
      Add = -> (a, b) { a + b }

      Divide = -> (a, b) { a / b }

      Subtract = -> (a, b) { a - b }

      Multiply = -> (a, b) { a * b }

      #
      # Comparables
      #
      GreaterThan = -> (a, b) { a > b }

      GreaterThanOrEqual = -> (a, b) { a >= b }

      LessThan = -> (a, b) { a < b }

      LessThanOrEqual = -> (a, b) { a <= b }
    end

    ALIASES = {
      GreaterThan: :Gt,
      GreaterThanOrEqual: :Gte,
      LessThan: :Lt,
      LessThanOrEqual: :Lte,
    }.freeze
  end
end
