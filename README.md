# RubyLambdas

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/ruby/lambdas`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby-lambdas', '~> 0.1.0', require: 'ruby/lambdas'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby-lambdas

## Usage

**Basics:**
```ruby
require "ruby/lambdas"

Strings::Strip.call(" hello ") # => "hello"

# Strings::Trim is an alias to the Strings::Strip function
Strings::Trim.call(" hello ") # => "hello"
```

**Composing functions (`RUBY_VERSION >= '2.6.0'`):**
```ruby
require "ruby/lambdas"
                                # -- Alternative syntax --
Slugify =                       # Slugify =
  Strings::FromObject           #   Strings::String
    .>> Strings::Strip          #     >> Strings::Trim      \
    .>> Strings::LowerCase      #     >> Strings::LowerCase \
    .>> Strings::GSub[' ', '-'] #     >> Strings::ReplaceAll[' ', '-']

# Reading the previous composition (Step by step)
# 1. Convert a given object (first input) as a String
# 2. Remove all whitespaces from both sides of a string.
# 3. Convert a string to all lower case.
# 4. Replace all occurrences of " " by "-".

# Usage

Slugify.(nil)                        # => ""
Slugify.(1)                          # => "1"
Slugify.(1.0)                        # => "1.0"
Slugify.(' I WILL be a url slug   ') # => "i-will-be-a-url-slug"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ruby-lambdas. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RubyLambdas project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ruby-lambdas/blob/master/CODE_OF_CONDUCT.md).
