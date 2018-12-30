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

                                # -- Alternative syntax --
Slugify =                       # Slugify =
  Strings::Strip                #   Strings::Trim           \
    .>> Strings::Downcase       #     >> Strings::LowerCase \
    .>> Strings::GSub[' ', '-'] #     >> Strings::ReplaceAll[' ', '-']

                                            # -- Alternative syntax --
slug = Slugify.(' I WILL be a url slug   ') # Slugify.call(' I WILL be a url slug   ')
                                            # Slugify[' I WILL be a url slug   ']
p slug # => "i-will-be-a-url-slug"

def slugify(value)
  value
    .then(&Strings::Trim)
    .then(&Strings::LowerCase)
    .then(&Strings::ReplaceAll[' ', '-'])
end

p slugify('    I will be a url SLUG ') # => "i-will-be-a-url-slug"

##############
# Benchmarks #
##############

require 'benchmark/ips'

def slugify2(value)
  value.strip.downcase.gsub(' ', '-')
end

Benchmark.ips do |x|
  x.report('method chaining') { slugify2(' I WILL be a url slug   ') }

  x.report('compose (.>>)') { Slugify.(' I WILL be a url slug   ') }

  x.report('pipeline (.then)') { slugify(' I WILL be a url slug   ') }

  x.compare!
end

# ruby -v examples/01.rb
# ruby 2.6.0p0 (2018-12-25 revision 66547) [x86_64-darwin17]
# Warming up --------------------------------------
#      method chaining    41.639k i/100ms
#        compose (.>>)    41.931k i/100ms
#     pipeline (.then)    32.379k i/100ms
# Calculating -------------------------------------
#      method chaining    464.961k (± 1.9%) i/s -      2.332M in   5.016985s
#        compose (.>>)    470.854k (± 1.6%) i/s -      2.390M in   5.077433s
#     pipeline (.then)    351.887k (± 2.2%) i/s -      1.781M in   5.063616s

# Comparison:
#        compose (.>>):   470853.9 i/s
#      method chaining:   464960.6 i/s - same-ish: difference falls within error
#     pipeline (.then):   351887.1 i/s - 1.34x  slower
