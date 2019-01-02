# frozen_string_literal: true

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'

  gem 'ruby-lambdas', require: 'ruby/lambdas'
end

############
# Examples #
############

p [2, 4, 8].map(&Numerics + 2) # => [4, 6, 10]
p [2, 4, 8].map(&Numerics - 2) # => [0, 2, 6]
p [2, 4, 8].map(&Numerics / 2) # => [1, 2, 4]
p [2, 4, 8].map(&Numerics * 2) # => [4, 8, 16]

# ---

p [2, 4, 8].select(&Numerics > 2)  # => [4, 8]
p [2, 4, 8].select(&Numerics >= 2) # => [2, 4, 8]
p [2, 4, 8].select(&Numerics < 2)  # => []
p [2, 4, 8].select(&Numerics <= 2) # => [2]
