# frozen_string_literal: true

raise 'Wrong Ruby version!' unless RUBY_VERSION >= '2.6.0'

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'

  gem 'ruby-lambdas', require: 'ruby/lambdas'
  gem 'benchmark-ips', '~> 2.7', '>= 2.7.2'
end

############
# Examples #
############

#
# Using Data Pipeline with the `then` method & `ruby/lambdas`
#
class Slugifier
  def initialize(sub, new_sub)
    @sub = sub
    @new_sub = new_sub
  end

  def call(value)
    value
      .then(&Strings::Strip)
      .then(&Strings::Downcase)
      .then(&Strings::GSub[@sub, @new_sub])
  end
end

Slugify1 = Slugifier.new(' ', '-')

                                        # -- Alternative syntax --
p Slugify1.(' I will Be a urL slug   ') # Slugify.call(' I will Be a urL slug   ')

#
# The code below is similar to the previous one.
# It also uses the data pipeline with the `then` method.
# But instead of the `ruby/lambdas`, it defines instance private methods.
#
class Slugifier2
  def initialize(sub, new_sub)
    @sub = sub
    @new_sub = new_sub
  end

  def call(value)
    value
      .then(&method(:trim))
      .then(&method(:lower_case))
      .then(&method(:replace))
  end

  private

  def trim(str)
    str.strip
  end

  def lower_case(str)
    str.downcase
  end

  def replace(str)
    str.gsub(@sub, @new_sub)
  end
end

Slugify2 = Slugifier2.new(' ', '-')

p Slugify2.(' I will be a URL slug   ')

#
# Use composition instead of pipeline.
#
class Slugifier3
  def initialize(sub, new_sub)
    @function =
      Strings::Strip >> Strings::Downcase >> Strings::GSub[sub, new_sub]
  end

  def call(value)
    @function.call(value)
  end
end

Slugify3 = Slugifier3.new(' ', '-')

p Slugify3.(' I will be a URL slug   ')

#
# Use only Lambdas instead of classes
#
Slugifier4 = -> (sub, new_sub) do
  Strings::Strip >> Strings::Downcase >> Strings::GSub[sub, new_sub]
end

Slugify4 = Slugifier4.call(' ', '-')

p Slugify4.(' I will be a URL slug   ')

#
# Using common Method Chaining
#
class Slugifier5
  def initialize(sub, new_sub)
    @sub = sub
    @new_sub = new_sub
  end

  def call(value)
    value.strip.downcase.gsub(@sub, @new_sub)
  end
end

Slugify5 = Slugifier5.new(' ', '-')

p Slugify5.(' I will be a URL slug   ')

##############
# Benchmarks #
##############

require 'benchmark/ips'

Benchmark.ips do |x|
  x.report('Slugify1') { Slugify1.(' I WILL be a url slug   ') }

  x.report('Slugify2') { Slugify2.(' I WILL be a url slug   ') }

  x.report('Slugify3') { Slugify3.(' I WILL be a url slug   ') }

  x.report('Slugify4') { Slugify4.(' I WILL be a url slug   ') }

  x.report('Slugify5') { Slugify5.(' I WILL be a url slug   ') }

  x.compare!
end

# ruby -v examples/02.rb
# ruby 2.6.0p0 (2018-12-25 revision 66547) [x86_64-darwin17]
# Warming up --------------------------------------
#             Slugify1    32.102k i/100ms
#             Slugify2    18.719k i/100ms
#             Slugify3    41.726k i/100ms
#             Slugify4    41.916k i/100ms
#             Slugify5    41.679k i/100ms
# Calculating -------------------------------------
#             Slugify1    353.234k (± 1.6%) i/s -      1.798M in   5.090599s
#             Slugify2    197.407k (± 3.4%) i/s -    992.107k in   5.031920s
#             Slugify3    463.481k (± 2.2%) i/s -      2.337M in   5.044143s
#             Slugify4    470.417k (± 1.6%) i/s -      2.389M in   5.080262s
#             Slugify5    467.429k (± 1.3%) i/s -      2.376M in   5.083347s

# Comparison:
#             Slugify4:   470416.6 i/s
#             Slugify5:   467429.1 i/s - same-ish: difference falls within error
#             Slugify3:   463481.2 i/s - same-ish: difference falls within error
#             Slugify1:   353234.4 i/s - 1.33x  slower
#             Slugify2:   197407.0 i/s - 2.38x  slower
