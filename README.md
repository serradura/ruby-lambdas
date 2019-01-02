# RubyLambdas

Expose Ruby object methods as lambdas (functions).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby-lambdas', require: 'ruby/lambdas'
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

# Other ways to call a lambda (function):
Strings::Trim[" hello "]
Strings::Trim.(" hello ")    # Syntactic sugar to hide “call”.
Strings::Trim.===(" hello ") # This allows a proc object to be the target of a when clause in a case statement.
Strings::Trim.yield(" hello ")
```

**Partial application (curried functions):**

```ruby
require "ruby/lambdas"

# We call a function with fewer arguments than it expects and It returns a
# function that takes the remaining arguments.
# And this is called Partial Application of Functions. e.g:

Strings::GSub.call(/[aeiou]/, "hello", "*")           # => "h*ll*"
Strings::GSub.call(/[aeiou]/).call("hello", "*")      # => "h*ll*"
Strings::GSub.call(/[aeiou]/).call("hello").call("*") # => "h*ll*"

# Last example with an alternative syntax:
Strings::GSub.(/[aeiou]/).("hello").("*") # => "h*ll*"

# ---

replace_vowels = Strings::GSub.call(/[aeiou]/)

replace_vowels.call("_", "banana") # => "b_n_n_"

# ---

hide_vowels = replace_vowels.call("*")

hide_vowels.call("hello") # => "h*ll*"
```

**Pipelines:**

```ruby
require "ruby/lambdas"

###########################
# RUBY_VERSION >= '2.6.0' #
###########################

value = ' I WILL be a url slug   '

value
  .then(&Strings::Strip)
  .then(&Strings::Downcase)
  .then(&Strings::GSub[' ', '-'])

# => "i-will-be-a-url-slug"

###########################
# RUBY_VERSION >= '2.5.0' #
###########################

value = ' I WILL be a url slug   '

value
  .yield_self(&Strings::Strip)
  .yield_self(&Strings::Downcase)
  .yield_self(&Strings::GSub[' ', '-'])

# => "i-will-be-a-url-slug"
```

**Composing functions (`RUBY_VERSION >= '2.6.0'`):**
```ruby
require "ruby/lambdas"
                                # -- Alternative syntax --
Slugify =                       # Slugify =
  Strings::FromObject           #   Strings::String
    .>> Strings::Strip          #     >> Strings::Trim      \
    .>> Strings::Downcase       #     >> Strings::LowerCase \
    .>> Strings::GSub[' ', '-'] #     >> Strings::ReplaceAll[' ', '-']

# Reading the previous composition (Step by step):
#   1. Convert a given object (first input) as a String
#   2. Remove all whitespaces from both sides of a string.
#   3. Convert a string to all lower case.
#   4. Replace all occurrences of " " by "-".

#########
# Usage #
#########
Slugify.(nil)                        # => ""
Slugify.(1)                          # => "1"
Slugify.(1.0)                        # => "1.0"
Slugify.(' I WILL be a url slug   ') # => "i-will-be-a-url-slug"
```

### Do you like it?

So, look in [examples folder](https://github.com/serradura/ruby-lambdas/tree/master/examples) to see more ideas and benchmarks.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/serradura/ruby-lambdas. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RubyLambdas project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/serradura/ruby-lambdas/blob/master/CODE_OF_CONDUCT.md).
