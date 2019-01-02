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
class Slugifier1
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

Slugify1 = Slugifier1.new(' ', '-')

                                        # -- Alternative syntax --
p Slugify1.(' I will Be a urL slug   ') # Slugify.call(' I will Be a urL slug   ')

#
# Using Data Pipeline with the `then` method & `ruby/lambdas`
#                                            & generates only once the replace function.
#
class Slugifier2
  def initialize(sub, new_sub)
    @replace = Strings::GSub[sub, new_sub]
  end

  def call(value)
    value
      .then(&Strings::Strip)
      .then(&Strings::Downcase)
      .then(&@replace)
  end
end

Slugify2 = Slugifier2.new(' ', '-')

                                        # -- Alternative syntax --
p Slugify2.(' I will Be a urL slug   ') # Slugify.call(' I will Be a urL slug   ')

#
# The code below is similar to the first implementation.
# It also uses the data pipeline with the `then` method.
# But instead of the `ruby/lambdas`, it defines instance private methods.
#
class Slugifier3
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

Slugify3 = Slugifier3.new(' ', '-')

p Slugify3.(' I will be a URL slug   ')

#
# Use composition instead of pipeline.
#
class Slugifier4
  def initialize(sub, new_sub)
    @function =
      Strings::Strip >> Strings::Downcase >> Strings::GSub[sub, new_sub]
  end

  def call(value)
    @function.call(value)
  end
end

Slugify4 = Slugifier4.new(' ', '-')

p Slugify4.(' I will be a URL slug   ')

#
# Use only Lambdas instead of classes
#
Slugifier5 = -> (sub, new_sub) do
  Strings::Strip >> Strings::Downcase >> Strings::GSub[sub, new_sub]
end

Slugify5 = Slugifier5.call(' ', '-')

p Slugify5.(' I will be a URL slug   ')

#
# Using common Method Chaining
#
class Slugifier6
  def initialize(sub, new_sub)
    @sub = sub
    @new_sub = new_sub
  end

  def call(value)
    value.strip.downcase.gsub(@sub, @new_sub)
  end
end

Slugify6 = Slugifier6.new(' ', '-')

p Slugify6.(' I will be a URL slug   ')

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

  x.report('Slugify6') { Slugify6.(' I WILL be a url slug   ') }

  x.compare!
end

# ruby -v examples/02.rb
# ruby 2.6.0p0 (2018-12-25 revision 66547) [x86_64-darwin17]
# Warming up --------------------------------------
#             Slugify1    32.149k i/100ms
#             Slugify2    42.850k i/100ms
#             Slugify3    18.885k i/100ms
#             Slugify4    41.644k i/100ms
#             Slugify5    42.273k i/100ms
#             Slugify6    42.046k i/100ms
# Calculating -------------------------------------
#             Slugify1    353.043k (± 1.1%) i/s -      1.768M in   5.009066s
#             Slugify2    478.121k (± 1.2%) i/s -      2.400M in   5.019572s
#             Slugify3    198.989k (± 1.7%) i/s -      1.001M in   5.031499s
#             Slugify4    467.207k (± 1.4%) i/s -      2.374M in   5.081706s
#             Slugify5    463.900k (± 5.0%) i/s -      2.325M in   5.026941s
#             Slugify6    463.345k (± 1.5%) i/s -      2.355M in   5.082800s

# Comparison:
#             Slugify2:   478121.3 i/s
#             Slugify4:   467207.4 i/s - same-ish: difference falls within error
#             Slugify5:   463900.4 i/s - same-ish: difference falls within error
#             Slugify6:   463345.1 i/s - 1.03x  slower
#             Slugify1:   353043.2 i/s - 1.35x  slower
#             Slugify3:   198989.5 i/s - 2.40x  slower
