raise 'Wrong Ruby version!' unless RUBY_VERSION >= '2.6.0'

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'

  gem 'ruby-lambdas', require: 'ruby/lambdas'
end

class Slugifier
  def initialize(sub, new_sub)
    @sub = sub
    @new_sub = new_sub
  end

  def call(value)
    String(value)
      .then(&Strings::Strip)
      .then(&Strings::Downcase)
      .then(&Strings::GSub[' ', '-'])
  end
end

Slugify = Slugifier.new(' ', '-')

                                        # -- Alternative syntax --
p Slugify.(' I will Be a urL slug   ') # Slugify.call(' I will Be a urL slug   ')

#
# The code below is the same of the previous.
# But you don't need to implement the methods, because of the `ruby/lambdas`.
#
class Slugifier2
  def initialize(sub, new_sub)
    @sub = sub
    @new_sub = new_sub
  end

  def call(value)
    String(value)
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

                                        # -- Alternative syntax --
p Slugify2.(' I will be a URL slug   ') # Slugify2.call(' I will be a URL slug   ')
