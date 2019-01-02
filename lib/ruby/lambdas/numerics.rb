module Numerics
  require_relative "import"
  require_relative "numerics/to_export"

  RubyLambdas::Import.(from: RubyLambdas::Numerics, to: self)

  #
  # Operators
  #
  def self.+(a)
    Add[a]
  end

  def self./(b)
    -> a { Divide[a, b] }
  end

  def self.-(b)
    -> a { Subtract[a, b] }
  end

  def self.*(a)
    Multiply[a]
  end

  #
  # Comparables
  #
  def self.>(b)
    -> a { GreaterThan[a, b] }
  end

  def self.>=(b)
    -> a { GreaterThanOrEqual[a, b] }
  end

  def self.<(b)
    -> a { LessThan[a, b] }
  end

  def self.<=(b)
    -> a { LessThanOrEqual[a, b] }
  end
end
