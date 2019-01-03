# frozen_string_literal: true

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'

  gem 'ruby-lambdas', require: 'ruby/lambdas'
end

############
# Examples #
############

p ["2", "4", "8"].map(&Numerics + "2") # => ["22", "24", "28"]

# ---

require "ruby/lambdas/strict-mode"

p [2, 4, 8].map(&Numerics + 2) # => [4, 6, 10]

begin
  p ["2", "4", "8"].map(&Numerics + "2")
rescue TypeError => e
  p e # => #<TypeError: "2" must be Numeric>
end

p ["2 ", " 4", "8 "].map(&Strings::Strip) # => ["2", "4", "8"]

begin
  p [2, 4, 8].map(&Strings::Strip)
rescue TypeError => e
  p e # => #<TypeError: 2 must be a String>
end
