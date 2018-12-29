raise 'Wrong Ruby version!' unless RUBY_VERSION >= '2.6.0'

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'

  gem 'ruby-lambdas', require: 'ruby/lambdas'
end

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
  String(value)
    .then(&Strings::Trim)
    .then(&Strings::LowerCase)
    .then(&Strings::ReplaceAll[' ', '-'])
end

p slugify('    I will be a url SLUG ') # => "i-will-be-a-url-slug"
