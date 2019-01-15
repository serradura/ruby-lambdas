module Numerics
  require_relative "core/strict_mode/disable"
  require_relative "core/import"
  require_relative "numerics/to_export"
  require_relative "numerics/type_error"

  RubyLambdas::Import.(from: RubyLambdas::Numerics, to: self)

  #
  # Operators
  #
  def self.+(a)
    Add[a]
  end

  def self./(b)
    Divide[b]
  end

  def self.-(b)
    Subtract[b]
  end

  def self.*(a)
    Multiply[a]
  end

  #
  # Comparables
  #
  def self.>(b)
    GreaterThan[b]
  end

  def self.>=(b)
    GreaterThanOrEqual[b]
  end

  def self.<(b)
    LessThan[b]
  end

  def self.<=(b)
    LessThanOrEqual[b]
  end
end
